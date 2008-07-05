# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def textile_link(text)
    %Q|<a href="http://hobix.com/textile/quick.html" target="_blank" onclick='window.open("http://hobix.com/textile/quick.html","redRef","height=600,width=550,channelmode=0,dependent=0,directories=0,fullscreen=0,location=0,menubar=0,resizable=0,scrollbars=1,status=1,toolbar=0");return false;'>#{text}</a>|
  end
  
  def login_logout
    if logged_in?
      link_to("Adicionar sessão", new_talk_url) +
      #{}" | " + 
      link_to("Profile", :controller => "account", :action => "profile") + 
      #{}" | " +
      link_to("Details", :controller => "account", :action => "details") + 
      #{}" | " +
      link_to("Logout", logout_path)
    else
      link_to("Login", login_path) + link_to("Signup", signup_path)
    end
  end
  
  def greetings
    return "Hey #{self.current_user} &mdash; " if logged_in?
    ""
  end
  
  def menu
    "<div id=\"menu\">" + greetings + "<a href=\"/\">Home</a>" + login_logout + "</div>"
  end
  
  def flash_message(message_key, css_class, css_element = :div, show_anyway = true)
    if show_anyway
      "<#{css_element} id=\"#{message_key}\" class=\"mb #{css_class}\" #{"style=\"display:none\"" if !flash[message_key]}>#{flash[message_key]}</#{css_element}>"
    else
      "<#{css_element} id=\"#{message_key}\" class=\"mb #{css_class}\">#{flash[message_key]}</#{css_element}>" if !!flash[message_key]
    end
  end
  
  def open_id_request?
    (params[:openid] == "true") || (!flash[:open_id_errors].blank?)
  end
end
