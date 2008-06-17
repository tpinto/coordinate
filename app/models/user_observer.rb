class UserObserver < ActiveRecord::Observer
  def after_create(user)
    UserNotifier.deliver_signup_with_email(user) unless !user.identity_url.blank? or user.status == 1
  end
  
  def after_save(user)
    if user.status == 1
      @event = Event.find :first
      @event.users << user unless @event.users.include? user
      @event.save!
    end
  end
end