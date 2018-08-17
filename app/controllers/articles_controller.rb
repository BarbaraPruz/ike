require 'pry'
class ArticlesController < ApplicationController
    before_action :require_logged_in
    before_action :require_admin, only: [:new, :create, :destroy, :edit, :update]

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
        @article = Article.create(article_params) 
        if @article
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
        @article = Article.find(params[:id])
        if !@article   
            redirect_to topics_path, flash[:alert] ="Article not found. Id #{params[:id]}"
        end
        @article.update(article_params)
        redirect_to topics_path    
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
        params.require(:article).permit(:title, :content, :topic_id, :new_topic)
    end
end