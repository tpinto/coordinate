class EventsController < ApplicationController
  
  def index
    @users = @event.users
    @talks = @event.talks
    @posts = Post.find :all, :order => "id DESC"
  end
  
  def feed
    @items = []
    @items << Post.find(:all, :limit => 20)
    @items << Talk.find(:all, :limit => 20)
    @items << Comment.find(:all, :limit => 20)
    
    @items.flatten!
    @items.sort!{|a,b| a.created_at <=> b.created_at}
    @items.slice!(0,20)
    
    response.headers['Content-Type'] = 'application/rss+xml'
    render :layout => false
  end
end
