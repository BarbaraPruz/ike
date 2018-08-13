module ApplicationHelper

    def home_url
        if logged_in?
          return user_home_path(session[:user_id])
        else
          return welcome_path
        end
    end  
end