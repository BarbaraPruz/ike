class ArticlesController < ApplicationController
    before_action :require_logged_in
    before_action :require_admin, only: [:new, :create, :destroy, :edit, :update]

    def index
        @articles = Array.new   # real work is done in index_data through ajax
    end

    def index_data
        @sort_field = params[:sort] ? params[:sort] : "topic"
        @articles = Article.sort_by(@sort_field)
        render json: @articles
    end

    def show
        @article = Article.find(params[:id])
    end

    def show_next
        # Not efficient but will fix with JSON backend
        last_article = Article.find(params[:id])
        @topic = last_article.topic     
        article_ids = @topic.article_ids  
        last_index = last_article.id
        new_index = article_ids.find_index { | id | 
            id==last_index 
        }
        new_index+=1
        if (new_index < 0) || (new_index == article_ids.length)
            new_index = 0
        end
        @article = Article.find_by(:id => article_ids[new_index])
            # to do: fix url, currently showing last article id 
            # to do: share common template with articles show but with other buttons
            #        and note that any links (like add bookmark) should come back to here!
        render :show        
    end

    def like
        get_article
        @article.update(:helpful_count => @article.helpful_count+1) 
        redirect_to @article
    end

    def new
        @article = Article.new()
        @topics = Topic.all
    end

    def create
        @article = Article.create(article_params) 
        if @article.valid?
            redirect_to @article
        else
            @topics = Topic.all
            render :new
        end        
    end

    def edit
        get_article
        @topics = Topic.all
    end
    def update
        get_article
        @article.update(article_params)
        if @article.valid?
            redirect_to @article 
        else
            @topics = Topic.all
            render :edit
        end
    end

    def destroy
        get_article
        @article.destroy
        redirect_to articles_path
    end

    private

    def article_params
        params.require(:article).permit(:title, :content, :topic_id, :new_topic)
    end

    def get_article
        @article = Article.find(params[:id])
        if !@article 
            redirect_to user_path(@current_user), :alert => "Article not found. Article Id #{params[:id]}"
        end
    end

end