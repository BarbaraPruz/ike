#require 'byebug'
#require 'pry'

class ArticlesController < ApplicationController
    before_action :require_logged_in
    before_action :require_admin, only: [:new, :create, :destroy, :edit, :update]

    def index
        @sort_field = params[:sort] ? params[:sort] : "topic"
        @articles = Article.sort_by(@sort_field)
    end

    def show
        @article = Article.find(params[:id])
    end

    def like
    #    byebug if params[:id] == '4' # ex. enter byebug if id is 4
    #    byebug  # always go to debugger here
    #    binding.pry
        get_article
        @article.update(:helpful_count => @article.helpful_count+1) 
        redirect_to @article
    end

    def new
        @article = Article.new()
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
        get_article
        @topics = Topic.all
    end
    def update
        get_article
        @article.update(article_params)
        if @article.valid?
            redirect_to @article 
        else
            @topics = Topic.all
            render :edit
        end
    end

    def destroy
        get_article
        @article.destroy
        redirect_to articles_path
    end

    private

    def article_params
        params.require(:article).permit(:title, :content, :topic_id, :new_topic)
    end

    def get_article
        @article = Article.find(params[:id])
        if !@article 
            redirect_to user_path(@current_user), :alert => "Article not found. Article Id #{params[:id]}"
        end
    end

end