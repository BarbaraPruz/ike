class ArticlesController < ApplicationController
    before_action :require_logged_in
    before_action :require_admin, only: [:new, :create, :destroy, :edit, :update]

    def index
        @sort_field = params[:sort] ? params[:sort] : "topic"
        @articles = Article.sort_by(@sort_field)
    end

    def show
        get_article_and_topic_instance_vars
    end

    def like
        get_article_and_topic_instance_vars
        @article.update(:helpful_count => @article.helpful_count+1) 
        redirect_to topic_article_path(@topic, @article)
    end

    def new
        @article = Article.new()
        @topics = Topic.all
    end

    def create
        @article = Article.create(article_params) 
        if @article.valid?
            redirect_to topic_article_path(@article.topic, @article)
        else
            @topics = Topic.all
            render :new
        end        
    end

    def edit
        get_article_and_topic_instance_vars
        @topics = Topic.all
    end
    def update
        get_article_and_topic_instance_vars
        @article.update(article_params)
        if @article.valid?
            redirect_to topic_article_path(@article.topic_id, @article) 
        else
            @topics = Topic.all
            render :edit
        end
    end

    def destroy
        get_article_and_topic_instance_vars
        @article.destroy
        redirect_to articles_path
    end

    private

    def article_params
        params.require(:article).permit(:title, :content, :topic_id, :new_topic)
    end

    def get_article_and_topic_instance_vars
        @article = Article.find(params[:id])
        @topic = Topic.find(params[:topic_id])
        if !@article || !@topic
            redirect_to user_path(@current_user), :alert => "Article/Topic not found. Article Id #{params[:id]}"
        end
    end

end