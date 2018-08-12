require 'pry'
class SessionsController < ApplicationController

    def create
        temp_user = User.new(email: params[:email])
        @user = User.find_by(email: params[:email])
        if !@user
            flash[:alert] = "User Email not found."
            @user = temp_user  # so user can see what they entered
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
        raise params.inspect
    end

end