class SessionsController < ApplicationController
  
  def create
    failed_openid_login "Por favor, introduza um OpenID válido." and return if using_open_id_but_without_open_id?
    
    if using_open_id?
      open_id_authentication(params[:openid_url])
    else
      password_authentication(params[:email], params[:password])
    end
  end

  def new
  end

  def destroy
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    flash[:notice] = "YAY, logged out."
    redirect_back_or_default('/')
  end

  protected

  def password_authentication(email, password)
    self.current_user = User.authenticate(email, password)
    if logged_in?
      successful_login
    else
      failed_regular_login "Os dados de login estão errados. Para pedir uma nova password, <a href=\"/account/resetpassword\">clique aqui.</a>"
    end
  end

  def open_id_authentication(identity_url)
    # Pass optional :required and :optional keys to specify what sreg fields you want.
    # Be sure to yield registration, a third argument in the #authenticate_with_open_id block.
    authenticate_with_open_id(identity_url, 
        :required => [ :fullname, :email ]) do |status, identity_url, registration|

      case status.code
      when :missing
        failed_openid_login "Este OpenID não foi encontrado."
      when :canceled
        failed_openid_login "A verificação foi cancelada."
      when :failed
        failed_openid_login "A verificação falhou."
      when :successful
          @user = User.find_or_create_by_identity_url(identity_url)
          
          if @user.new_record?
            @user.name = registration['fullname']
            @user.email = registration['email']
            @user.status = 1
            @user.save(false)
          end
          self.current_user = @user
          
          successful_login
      end
    end
  end
  
  private
  
  def using_open_id_but_without_open_id?
    params[:openid_url] and params[:openid_url].blank?
  end
  
  def failed_openid_login(message = "Authentication failed.")
    flash[:open_id_errors] = message
    redirect_back_or_default('/')
  end
  
  def failed_regular_login(message = "Authentication failed.")
    flash[:login_errors] = message
    redirect_back_or_default('/')
  end

  def successful_login
    flash[:notice] = "YAY! Logged in."
    redirect_to '/'
  end
end
