class UsersController < ApplicationController
    before_action :require_logged_in, except: [:new, :create]
    before_action :require_admin, only: [:index, :destroy]
    before_action :require_admin_or_same_user, only: [:edit, :update]

    def index
        @users=User.all.sort { |a,b| a.name <=> b.name }  
    end

    def edit
        get_user_instance_var
    end

    def update
        get_user_instance_var
        if !@user.update(user_params)
            render :edit
        else
            @user.update(:admin=>(params[:user][:admin]=="1" ? true : false))
            redirect_to user_update_return_path
        end  
    end
    
    def new
        redirect_to user_path(@current_user.id) if logged_in?
        @user = User.new
    end

    def create
        redirect_to user_path(@current_user.id) if logged_in?
        @user = User.create(user_params)
        if @user.valid?
            session[:user_id] = @user.id
            redirect_to user_path(@user.id)
        else
            render :new
        end
    end

    def show
        @latest_articles = Article.get_latest(5)
    end

    def destroy
        if params[:id] == @current_user[:id]
            redirect_to users_path, :alert => "Sorry - you cannot delete yourself!"
        else
            get_user_instance_var
            @user.destroy
            redirect_to users_path
        end
    end

    private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def user_update_return_path
        is_admin? ? users_path : user_path(current_user)
    end

    def require_admin_or_same_user
        if !is_admin? && current_user.id.to_s != params[:id]  
            redirect_to user_path(@current_user.id), :alert => "Operation not allowed"
        end
    end

    def get_user_instance_var
        @user=User.find(params[:id])
        if !@user
            redirect_to user_update_return_path, :alert => "User not found."
        end 
    end

end
