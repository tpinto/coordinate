class UsersController < ApplicationController
  before_filter :login_required, :only => [:show]
  
  cache_sweeper :user_sweeper, :only => [:create]
  
  # shows the signup form
  def new
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def index
    unless fragment_exist?("users_page")
      @users = User.find :all, :order => "id DESC"
      @openid_count = User.count :conditions => "identity_url is not null"
    end
  end
  
  # receives the new user form post
  def create
    @user = User.new(params[:user])
    @user.save!
    self.current_user = @user
    
    flash[:message] = "Registo completo!"
    redirect_to root_path
    
  rescue ActiveRecord::RecordInvalid
    user = User.find_by_email(params[:user][:email])
    
    if user and user.used_open_id?
      flash.now[:signup_errors] = "Este email pertence a um registo com OpenID.<br>O login respectivo pode ser feito <a href=\"/login/openid\">aqui</a>."
    else
      flash.now[:name_errors] = @user.errors.on(:name)
      flash.now[:email_errors] = @user.errors.on(:email)
      if @user.errors.on(:password) == "doesn't match confirmation"
        flash.now[:password_errors] = "não é igual à confirmação &darr;"
        flash.now[:confirmation_errors] = "não é igual à password &uarr;"
      else
        flash.now[:password_errors] = @user.errors.on(:password)
        flash.now[:confirmation_errors] = @user.errors.on(:password_confirmation)
      end
      flash.now[:signup_errors] = @user.errors.full_messages.join("<br/>")
    end
    
    render :action => "new" and return
  end
  
  def validate_user
    @user = User.new(params[:user])
    what = params[:toTest].to_sym
    if @user.valid?
      render :update do |page|
        page.hide "#{what}_errors"
      end
    else
      render :update do |page|
        if @user.errors.on(what).nil?
          page.hide "#{what}_errors"
        elsif @user.errors.on(what)
          page.replace_html "#{what}_errors", @user.errors.on(what)
          page.show "#{what}_errors"
        end
      end
    end
  end
  
  # shows the user details form
  def edit
  end
  
  # receives the edit user form post
  def update
  end
end
