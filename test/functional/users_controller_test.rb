require File.dirname(__FILE__) + '/../test_helper'

class UsersControllerTest < ActionController::TestCase

  def test_index_caching
    get :index
    assert_cached_fragment "users_page"

    create_user
    assert_not_cached_fragment "users_page"
    
    get :index
    assert_cached_fragment "users_page"
  end
  
protected
  
  def create_user
    post :create, :user => {:name => "joao ratao", :email => "joao@example.com", :password => "teste", :password_confirmation => "teste"}
  end
end
