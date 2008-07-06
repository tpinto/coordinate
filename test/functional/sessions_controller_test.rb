require File.dirname(__FILE__) + '/../test_helper'

class SessionsControllerTest < ActionController::TestCase

  def test_login
    get :new
    
    assert_nil session[:user]
    
    login_as :quentin
    
    assert_not_nil session[:user]
    assert_equal users(:quentin).id, session[:user]
  end

end
