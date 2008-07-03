class EventsController < ApplicationController
  
  def index
    @users = @event.users
    @talks = @event.talks
    @posts = Post.find :all, :order => "id DESC"
  end
  
  def feed
    it = []
    it << Post.find(:all, :limit => 20)
    it << Talk.find(:all, :limit => 20)
    it << Comment.find(:all, :limit => 20)
      
    it.flatten!
    it.sort!{|a,b| a.created_at <=> b.created_at}
    @items = it.slice(0,20)
    
    response.headers['Content-Type'] = 'application/rss+xml'
    render :layout => false
  end
end
