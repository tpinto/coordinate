# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def login_logout
    if logged_in?
      "Hey #{current_user.name || current_user.email} &mdash; #{link_to "Logout", logout_path}"
    else
      link_to "Login", login_path
    end
  end
end
