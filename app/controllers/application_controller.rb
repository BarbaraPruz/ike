class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :logged_in?, :is_admin?
  before_action :current_user

  def welcome
    redirect_to user_path(@current_user.id) if logged_in?
    @user = User.new
  end

  def logged_in?
    session[:user_id]
  end

  def is_admin?
    current_user && @current_user.admin
  end

  private

  def require_logged_in
    redirect_to welcome_path unless logged_in?
  end

  def require_admin
    redirect_to user_path(@current_user) if !is_admin?
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
