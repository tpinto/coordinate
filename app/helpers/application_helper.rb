# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def login_logout
    if logged_in?
      link_to("Adicionar talk", new_talk_url) +
      " | " + 
      link_to("Profile", :controller => "account", :action => "details") + 
      " | " +
      link_to("Logout", logout_path)
    else
      link_to("Login", login_path) + " / " + link_to("Signup", signup_path)
    end
  end
  
  def greetings
    "Hey #{self.current_user} &mdash; " if logged_in?
  end
  
  def flash_message(message_key, css_class, css_element = :div, show_anyway = true)
    if show_anyway
      "<#{css_element} id=\"#{message_key}\" class=\"#{css_class}\" #{"style=\"display:none\"" if !flash[message_key]}>#{flash[message_key]}</#{css_element}>"
    else
      "<#{css_element} id=\"#{message_key}\" class=\"#{css_class}\">#{flash[message_key]}</#{css_element}>" if !!flash[message_key]
    end
  end
  
  def open_id_request?
    (params[:openid] == "true") || (!flash[:open_id_errors].blank?)
  end
end
