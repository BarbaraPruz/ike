# frozen_string_literal: true

# ArticlesController - handles RESTful routes for Articles model
class ArticlesController < ApplicationController
  before_action :require_logged_in
  before_action :require_admin, only: [:new, :create, :destroy, :edit, :update]

  def index
    @sort_field = params[:sort] || 'topic'
    @articles = Article.sort_by(@sort_field)
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
    @topics = Topic.all
  end

  def create
    @article = Article.create(article_params)
    if @article.valid?
      redirect_to @article
    else
      @topics = Topic.all
      render :new
    end
  end

  def edit
    find_article
    @topics = Topic.all
  end

  def update
    find_article
    @article.update(article_params)
    if @article.valid?
      redirect_to @article
    else
      @topics = Topic.all
      render :edit
    end
  end

  def destroy
    find_article
    @article.destroy
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :topic_id, :new_topic)
  end

  def find_article
    @article = Article.find(params[:id])
    return if @article

    redirect_to user_path(@current_user),
                alert: "Article not found. Article Id #{params[:id]}"
  end
end
