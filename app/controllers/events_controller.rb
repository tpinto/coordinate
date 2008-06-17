class EventsController < ApplicationController
  
  def index
    @users = @event.users
    @talks = @event.talks
  end
end
