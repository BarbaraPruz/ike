require 'pry'
class CommentsController < ApplicationController
    before_action :require_logged_in

    def create
        # Format JSON
        @comment = Comment.create(:user_id => @current_user.id, :article_id => params[:article_id],
            :content => params[:content]);
        ## To Do if comment !valid?
        render json: @comment       
    end

    private


end