class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :logged_in?
  
  def welcome
    @user = User.new
    #redirect_to login_path if !session[:name]
  end
  
  def logged_in?
    session[:user_id]
  end


end
