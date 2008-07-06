class AdminController < ApplicationController
  before_filter :admin_required, :except => [:login, :signup]
  before_filter :signup_first_user, :except => [:signup]
  before_filter :no_more_than_one_signup, :only => [:signup]
  
  cache_sweeper :post_sweeper, :only => [:new_post]
  
  def signup
    @admin = Admin.new
    
    return unless request.post?
    
    @admin.attributes = params[:admin]
    session[:admin] = @admin if @admin.save!

    redirect_to :action => :index and return if session[:admin]
  end
  
  def login
    return unless request.post?

    session[:admin] = Admin.find_by_username_and_password(params[:admin][:username],params[:admin][:password])
    
    redirect_to :action => :index and return if session[:admin]
  end
  
  def index
  end
  
  def new_post
    return unless request.post?
    Post.create(params[:post])
    redirect_to :action => :list_posts
  end
  
  def list_posts
    @posts = Post.find :all, :order => "id DESC"
  end
  
  protected
  
  def signup_first_user
    redirect_to :action => :signup and return if Admin.count.zero?
  end
  
  def no_more_than_one_signup
    redirect_to :action => :login and return if Admin.count > 0
  end
  
  def admin_required
    redirect_to "/" and return unless session[:admin]
  end
end
