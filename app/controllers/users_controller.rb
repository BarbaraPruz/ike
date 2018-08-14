class UsersController < ApplicationController

    def index
        if !logged_in?
            redirect_to welcome_path
        elsif !is_admin?
            redirect_to user_home_path(@current_user.id)
        else      
            @users=User.all
        end
    end

    def new
        redirect_to user_home_path(@current_user.id) if logged_in?
        @user = User.new
    end

    def create
        redirect_to user_home_path(@current_user.id) if logged_in?
        @user = User.new(user_params)
        if @user.valid?
            @user.email = @user.email.downcase
            @user.save
            session[:user_id] = @user.id
            redirect_to user_home_path(@user.id)
        else
            render :new
        end
    end

    def show
        redirect_to welcome_path if !logged_in?
    end

    private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
