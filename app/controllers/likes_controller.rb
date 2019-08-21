# frozen_string_literal: true

# LikesController - joins a user and an article
class LikesController < ApplicationController
  def create
    @article = Article.find_by(id: params[:article_id])
    like = Like.create(user_id: @current_user.id, article_id: @article.id)
    flash[:alert] = like.errors.full_messages.first unless like.valid?
    redirect_to article_path(@article)
  end
end
