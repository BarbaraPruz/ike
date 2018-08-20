require 'pry'
class ArticlesController < ApplicationController
    before_action :require_logged_in
    before_action :require_admin, only: [:new, :create, :destroy, :edit, :update]

    def index
        @articles = Article.sort_by("topic")
        @sort = sort_params("topic")
    end
    def sort
        params[:sort] = "topic" if !params[:sort]
        @articles = Article.sort_by(params[:sort])
        @sort = sort_params(params[:sort])
        render :index
    end

    def show
        get_article_and_topic_instance_vars
    end

    def like
        get_article_and_topic_instance_vars
        @article.update(:helpful_count => @article.helpful_count+1) 
        render :show
    end

    def new
        @article = Article.new()
        @topics = Topic.all
    end

    def create
        @article = Article.create(article_params) 
        if @article
            redirect_to topic_article_path(@article.topic, @article)
        else
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
        redirect_to topic_article_path(@topic, @article) 
    end

    def destroy
        get_article_and_topic_instance_vars
        Bookmark.clean(@article.id)
        @article.destroy
        redirect_to :index
    end

    private

    def article_params
        params.require(:article).permit(:title, :content, :topic_id, :new_topic)
    end

    def sort_params (checked)
        columns = [{value: "topic",display: "Topic"},
                   {value: "title",display: "Title"},
                   {value: "helpful_count",display: "Likes"},
                { value: "created_at",display: "Date"}]
        columns   
    end

    def get_article_and_topic_instance_vars
        @article = Article.find(params[:id])
        @topic = Topic.find(params[:topic_id])
        if !@article || !@topic
            redirect_to user_home_path(@current_user.id), flash[:alert] ="Article/Topic not found. Article Id #{params[:id]}"
        end
    end

end