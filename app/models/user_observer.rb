class UserObserver < ActiveRecord::Observer
  def after_create(user)
    @event = Event.find :first
    @event.users << user unless @event.users.include? user
    @event.save!
  end
end