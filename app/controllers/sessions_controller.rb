require 'pry'
class SessionsController < ApplicationController

    def create
        @user = User.find_by(email: params[:email].downcase)
        if !@user
            flash[:alert] = "User Email not found."
            @user = User.new(email: params[:email])        
            render :welcome
        elsif @user.authenticate(params[:password])
            session[:user_id] = @user.id
            redirect_to user_home_path(@user)
        else
            flash[:alert] ="Password incorrect."
            render :welcome
        end
    end

    def destroy
        session.delete :user_id
        redirect_to welcome_path
    end

end    