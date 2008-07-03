class UserNotifier < ActionMailer::Base

  def signup_with_email(user)
    setup_email(user)
    @subject    <<  'Registo'
    @body[:url] =   "http://barcamp.webreakstuff.com/account/details/#{user.activation_code}"
  end
  
  def reset_password(user)
    setup_email(user)
    @subject    <<  'Nova password'
    @body[:url] =   "http://barcamp.webreakstuff.com/account/details/#{user.activation_code}"    
  end
  
  def send_error(e,file,path,params)
    @recipients  = "tpinto@webreakstuff.com"
    @from        = "barcamp@webreakstuff.com"
    @subject     = "[Barcamp PT '08] #{(e.respond_to?("original_exception") ? e.original_exception.class.to_s : e.class.to_s)}"
    @sent_on     = Time.now
    @body[:e] = e
    @body[:file] = file
    @body[:path] = path
    @body[:params] = params
  end

  protected
  
  def setup_email(user)
    @recipients  = "#{user.email}"
    @from        = "barcamp@webreakstuff.com"
    @subject     = "[Barcamp PT '08] "
    @sent_on     = Time.now
    @body[:user] = user
  end
end
