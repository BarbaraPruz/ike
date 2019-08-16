module ApplicationHelper
  def home_path
    return user_path(session[:user_id]) if logged_in?
    
    welcome_path
  end

  def format_time(time)
    time.strftime('%d %b. %Y %H:%M')
  end

  def show_error_messages(ar_object)
    html = '<div id="error_explanation"><p>oops, there seem to be some problems:</p><ul>'
    ar_object.errors.full_messages.each do |message|
      html += "li>#{message}</li>"
    end
    html += '<ul></div>'
    html.html_safe
  end

  # article index sort helpers
  def sort_select_tag(sort_field)
    fields = [{ value: '', display: 'Choose Sort Field' },
              { value: 'topic', display: 'Topic' },
              { value: 'title', display: 'Title' },
              { value: 'likes', display: 'Likes' },
              { value: 'updated_at', display: 'Latest Update' }]

    html = "<select name='sort' id='sort'>"
    fields.each do |field|
      html += "<option #{sort_selected_option(field[:value], sort_field)} "
      html += " value=#{field[:value]}>#{field[:display]}</option>"
    end
    html.html_safe
  end

  def sort_selected_option(field, sort_field)
    field == sort_field ? "selected='selected'" : ''
  end
end
