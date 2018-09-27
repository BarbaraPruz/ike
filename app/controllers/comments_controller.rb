require 'pry'
class CommentsController < ApplicationController
    before_action :require_logged_in

    def create
        comment = Comment.create(:user_id => @current_user.id, :article_id => params[:article_id],
            :content => params[:content]);
        ## To Do if comment !valid?
        redirect_to article_path(params[:article_id])         
    end

    private


end