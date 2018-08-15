class BookmarksController < ApplicationController
    before_action :require_logged_in

    def create
        # To Do - verify article 
        bookmark = Bookmark.create(:article_id => params[:article_id], :user_id => @current_user.id)
        # To Do - handle errors?
        redirect_to user_path(@current_user)
    end

end