module ApplicationHelper

    def home_path
        if logged_in?
          return user_path(session[:user_id])
        else
          return welcome_path
        end
    end 
    
    def format_time (time)
      time.strftime("%d %b. %Y")
    end
end
