class EventsController < ApplicationController
  
  def index
    @users = User.find :all, :order => "id DESC", :limit => 10
    @user_count = User.count
    @talks = Talk.find :all, :order => "id DESC", :limit => 5
    @talk_count = Talk.count
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
