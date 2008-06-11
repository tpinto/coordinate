class UserNotifier < ActionMailer::Base

  def signup_with_email(user)
    setup_email(user)
    @subject    <<  'Registo por email: activação'
    @body[:url] =   "http://barcamp.webreakstuff.com/account/preferences/#{user.activation_code}"
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
