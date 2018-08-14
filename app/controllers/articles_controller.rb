class ArticlesController < ApplicationController
    before_action :require_logged_in

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

end