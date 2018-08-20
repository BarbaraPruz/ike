class BookmarksController < ApplicationController
    before_action :require_logged_in

    def new
        @article = Article.find_by(:id => params[:article_id])
        # To Do - verify article 
        @bookmark = Bookmark.new(:article_id => @article.id, :user_id => @current_user.id,
            :title => @article.title)
    end

    def create
        @article = Article.find_by(:id => params[:article_id])
        # To Do - verify article  and verify user is current user
        bookmark = Bookmark.create(bookmark_params)
        # To Do - handle errors?
        redirect_to topic_article_path(@article.topic, @article)
    end

    def destroy
        bookmark = Bookmark.find_by(:id => params[:id])
        if bookmark && bookmark.user_id==current_user.id
            bookmark.destroy
        else
            flash[:alert] ="Bookmark not found for you!"
        end
        redirect_to user_path(@current_user)
    end

    private
    def bookmark_params
        params.require(:bookmark).permit(:user_id, :article_id, :title)
    end
end