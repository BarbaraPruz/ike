class LikesController < ApplicationController

    def create
        @article = Article.find_by(:id => params[:article_id])
        @article.likes.create(user_id: @current_user.id)
        redirect_to article_path(@article)
    end

    private

end