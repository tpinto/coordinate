class AccountController < ApplicationController
  before_filter :login_required, :except => [:login, :logout, :resetpassword]
  
  cache_sweeper :user_sweeper, :only => [:details,:profile]

  def profile
    @user = self.current_user if logged_in?
    
    return unless request.post?
    
    @user.attributes = params[:user]
    @user.save!
    
    self.current_user = @user
    
    flash[:message] = "Detalhes alterados :)"
    redirect_to root_path
  rescue ActiveRecord::RecordInvalid
    render
  end

  def details
    @user = self.current_user if logged_in?
    #@user ||= User.find_by_activation_code(params[:id])

    return unless request.post?

    @user.attributes = params[:user]
    @user.save!

    self.current_user = @user

    flash[:message] = "Detalhes alterados :)"
    redirect_to root_path
  rescue ActiveRecord::RecordInvalid

    flash.now[:name_errors] = @user.errors.on(:name)
    flash.now[:email_errors] = @user.errors.on(:email)
    if @user.errors.on(:password) == "doesn't match confirmation"
      flash.now[:password_errors] = "não é igual à confirmação &darr;"
      flash.now[:confirmation_errors] = "não é igual à password &uarr;"
    else
      flash.now[:password_errors] = @user.errors.on(:password)
      flash.now[:confirmation_errors] = @user.errors.on(:password_confirmation)
    end

    render
  end

  def resetpassword
    return unless request.post?
    
    user = User.find_by_email(params[:user][:email])
    
    if !user.nil?
      p = user.reset_password!
      UserNotifier.deliver_reset_password(user,p)
      
      flash[:login_message] = "Foi enviado um email com nova pass. :)"
      redirect_to login_path and return
    else
      flash.now[:email_errors] = "Não existe esse email registado."
    end
  end
  
  def meals
    return unless request.post?
    current_user.almoco = params[:almosso]
    current_user.jantar = params[:jantar]
    current_user.save!
  end

  def login
    redirect_to login_path
  end
  
  def logout
    redirect_to logout_path
  end

end
