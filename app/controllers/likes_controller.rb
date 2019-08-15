class LikesController < ApplicationController
  def create
    @article = Article.find_by(:id => params[:article_id])
    if Like.userArticleNotLikedYet?(@current_user.id, @article.id)
      @article.likes.create(user_id: @current_user.id, article_id: @article.id)
    end
    redirect_to article_path(@article)
  end

  private
end
