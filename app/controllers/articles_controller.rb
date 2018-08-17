require 'pry'
class ArticlesController < ApplicationController
    before_action :require_logged_in
    before_action :require_admin, only: [:new, :create, :destroy]

    def show
        @article = Article.find(params[:id])
        @topic = Topic.find(params[:topic_id])
        if !@article || !@topic
            redirect_to user_home_path(@current_user.id), flash[:alert] ="Article/Topic not found. Id #{params[:id]}"
        end
    end

    def like
        @article = Article.find(params[:id])
        if !@article
            redirect_to user_home_path(@current_user.id), flash[:alert] ="Article not found. Id #{params[:id]}"
        end
        @article.update(:helpful_count => @article.helpful_count+1) 
        redirect_to topics_path
    end

    def new
        @article = Article.new()
        @topics = Topic.all
    end

    def create
        if params[:article][:topic].empty?
            topic = Topic.find_by(params[:article][:topic_id])
        else  
            topic = Topic.create(:name => params[:article][:topic])
            params[:article][:topic_id] = topic.id if topic
        end
        @article = Article.create(article_params) if topic
        if topic && @article 
            redirect_to topics_path
        else
            render :new
        end        
    end

    def edit
        @article = Article.find(params[:id])
        @topic = Topic.find(params[:topic_id])
        if !@article
            redirect_to topics_path, flash[:alert] ="Article not found. Id #{params[:id]}"
        end
        @topics = Topic.all
    end
    def update
        raise params.inspect
    end
    def destroy
        @article = Article.find(params[:id])
        if !@article
            redirect_to topics_path, flash[:alert] ="Article not found. Id #{params[:id]}"
        end
        @article.destroy
        redirect_to topics_path
    end

    private

    def article_params
        params.require(:article).permit(:title, :content, :topic_id)
    end
end