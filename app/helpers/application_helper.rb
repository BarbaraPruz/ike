module ApplicationHelper

    def home_path
        if logged_in?
          return user_path(session[:user_id])
        else
          return welcome_path
        end
    end 
    
    def get_topics
      "<option>Succulents</option><option>Weeds</option>".html_safe
    end
end
