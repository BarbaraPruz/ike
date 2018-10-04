module ApplicationHelper

    def home_path
        if logged_in?
          return user_path(session[:user_id])
        else
          return welcome_path
        end
    end 
    
    def format_time (time)
      time.strftime ("%Y-%m-%d %H:%M")
    end

    def show_error_messages (ar_object)
      
        html="<div id='error_explanation'><p>oops, there seem to be some problems:</p><ul>"
        ar_object.errors.full_messages.each do |message| 
            html += "<li>#{message}</li>"
        end
        html += "<ul></div>"
        html.html_safe
    end

end
