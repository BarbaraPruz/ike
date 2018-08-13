class ArticlesController < ApplicationController

    def show
        redirect_to welcome_path if !logged_in?
        @article = Article.find(params[:id])
        if !@article
            redirect_to user_home_path(@current_user.id), flash[:alert] ="Article not found. Id #{params[:id]}"
        end
    end


end