class AccountController < ApplicationController

  def signup
    @user = User.new(params[:user])
    return unless request.post?
    @user.save!
    #self.current_user = @user
    redirect_back_or_default(root_path)
    flash[:notice] = "Verifique o seu email"
  rescue ActiveRecord::RecordInvalid
    render :action => 'signup'
  end

  # say something nice, you goof!  something sweet.
  def index
    redirect_to(:action => 'signup') unless logged_in? || User.count > 0
  end
  
  def preferences
    @user = self.current_user if logged_in?
    @user ||= User.find_by_activation_code(params[:id])
    
    return unless request.post?
    
    @user.attributes = params[:user]
    @user.status = 1
    @user.save!
    
    self.current_user = @user
    
    redirect_to root_path
  rescue ActiveRecord::RecordInvalid
    render
  end

  def login
    redirect_to login_path
  end
  
  def logout
    redirect_to logout_path
  end  

end
