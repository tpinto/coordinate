class EventsController < ApplicationController
  caches_page :feed
  
  def index
    unless fragment_exist?("home_users")
      @users = User.find :all, :order => "id DESC", :limit => 10
      @user_count = User.count
    end

    unless fragment_exist?("home_talks")
      @talks = Talk.find :all, :order => "id DESC", :limit => 10
      @talk_count = Talk.count
    end
  
    unless fragment_exist?("home_intro")
      @posts = Post.find :all, :order => "id DESC"
    end
  end
  
  def feed
    it = []
    it << Post.find(:all, :limit => 20)
    it << Talk.find(:all, :limit => 20)
    it << Comment.find(:all, :limit => 20, :include => [:talk])
      
    it.flatten!
    it.sort!{|a,b| a.created_at <=> b.created_at}
    @items = it.slice(0,20)
    
    response.headers['Content-Type'] = 'application/rss+xml'
    render :layout => false
  end
end
