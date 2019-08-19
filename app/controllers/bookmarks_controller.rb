# frozen_string_literal: true

# BookmarksController - controller for Bookmarks model
class BookmarksController < ApplicationController
  before_action :require_logged_in
  before_action :fetch_article, only: [:new, :create]

  def new
    unless @article
      redirect_to user_path(@current_user.id), alert: 'Article not found.'
    end
    @bookmark = Bookmark.new(article_id: @article.id,
                             user_id: @current_user.id, title: @article.title)
  end

  def create
    if new_bookmark_params_valid?
      redirect_to user_path(@current_user.id),
                  alert: 'Article or User not found'
      return
    end
    @bookmark = Bookmark.create(bookmark_params)
    if @bookmark.valid?
      redirect_to @article
    else
      render :new
    end
  end

  def destroy
    bookmark = Bookmark.find_by(id: params[:id])
    if bookmark && bookmark.user_id == current_user.id
      bookmark.destroy
    else
      flash[:alert] = 'Bookmark not found for you!'
    end
    redirect_to user_path(@current_user)
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:user_id, :article_id, :title)
  end

  def fetch_article
    @article = Article.find_by(id: params[:article_id])
  end

  def new_bookmark_params_valid?
    @article && current_user.id == params[:bookmark][:user_id]
  end
end
