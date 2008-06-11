class UserObserver < ActiveRecord::Observer
  def after_create(user)
    UserNotifier.deliver_signup_with_email(user)
  end
end