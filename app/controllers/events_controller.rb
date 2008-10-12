class EventsController < ApplicationController
  #caches_page :feed
  session :off, :only => [:feed]
  
  def index
    unless fragment_exist?("home_users")
      @users = User.find :all, :order => "id DESC", :limit => 10
      @user_count = User.count
    end

    unless fragment_exist?("home_talks")
      @talks = Talk.find :all, :order => "id DESC", :limit => 10, :include => [:user]
      @talk_count = Talk.count
    end
  
    unless fragment_exist?("home_intro")
      @post = Post.find :first, :order => "id DESC"
    end
  end
  
  def feed
    it = []
    it << Post.find(:all, :limit => 20, :order => "id DESC")
    it << Talk.find(:all, :limit => 20, :order => "id DESC")
    it << Comment.find(:all, :limit => 20, :include => [:talk], :order => "id DESC")

    it.flatten!
    it.sort!{|a,b| a.created_at <=> b.created_at}
    it.reverse!
    @items = it.slice(0,20)
    @items.reverse!
        
    response.headers['Content-Type'] = 'application/rss+xml'
    render :layout => false
  end
  
  def survey
    
  end
  
  def stats
    @users_count = User.count :all
    @sessions_count = Talk.count :all
  end
  
  def buzz
    @tags = params[:tag] || "barcamppt08"
  end
end
