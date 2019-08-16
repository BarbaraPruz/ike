# LikesController - joins a user and an article
class LikesController < ApplicationController
  
  def create
    @article = Article.find_by(id: params[:article_id])
    if Like.user_article_not_liked_yet?(@current_user.id, @article.id)
      @article.likes.create(user_id: @current_user.id, article_id: @article.id)
    end
    redirect_to article_path(@article)
  end
end
