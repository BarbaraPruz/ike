class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def welcome
    @user = User.new
    #redirect_to login_path if !session[:name]
  end
  
end
