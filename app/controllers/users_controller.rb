class UsersController < ApplicationController
    before_action :require_logged_in, except: [:new, :create]
    before_action :require_admin, only: [:index, :edit, :update]

    def index
        @users=User.all
    end

    def edit   
        @user=User.find(params[:id])
        if !@user
            flash[:alert] ="User not found."
            redirect_to user_path(@current_user.id)
        end
    end

    def update
        # to do:  current user can update or admin
        @user = User.find(params[:id])
        if !@user
            flash[:alert] ="User not found."
            redirect_to users_path
        elsif !@user.update(user_params)
            render :edit
        else
            @user.update(:admin=>(params[:user][:admin]=="1" ? true : false))
            redirect_to users_path
        end
    end
    
    def new
        redirect_to user_path(@current_user.id) if logged_in?
        @user = User.new
    end

    def create
        redirect_to user_path(@current_user.id) if logged_in?
        @user = User.new(user_params)
        @user.email = @user.email.downcase
        if @user.valid?
            @user.save
            session[:user_id] = @user.id
            redirect_to user_path(@user.id)
        else
            render :new
        end
    end

    def show
        # to do: show logged in user unless admin
    end

    def destroy
        if params[:id] == @current_user[:id]
            flash[:alert] ="Sorry - you cannot delete yourself!"
            redirect_to users_path
        else
            @user = User.find(params[:id])
            if !@user
                flash[:alert] ="User not found."
                redirect_to users_path
            else
                @user.destroy
                redirect_to users_path
            end
        end
    end

    private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
