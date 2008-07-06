require File.dirname(__FILE__) + '/../test_helper'

class TalksControllerTest < ActionController::TestCase
  
  def test_index_caching
    get :index
    assert_cached_fragment "talks_page"
        
    create_talk
    assert_not_cached_fragment "talks_page"
    
    get :index
    assert_cached_fragment "talks_page"
  end
  
protected

  def create_talk
    login_as :tiago
    assert_equal users(:tiago).id, session[:user]
    
    assert_difference Talk, :count do
      post :create, :talk => {:title => "talk title", :description => "talk description"}
    end
  end
end
