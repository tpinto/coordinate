require File.dirname(__FILE__) + '/../test_helper'

class CacheSweepingTest < ActionController::IntegrationTest

  def test_feed_cache_expiration_on_talk_creation
    feed_url = "/feed.xml"
    
    get feed_url
    assert_cached_page feed_url
    
    create_talk
    assert_not_cached_page feed_url
    
    get feed_url
    assert_cached_page feed_url
  end
  
  def test_feed_cache_expiration_on_post_creation
    feed_url = "/feed.xml"
    
    get feed_url
    assert_cached_page feed_url
    
    create_post
    assert_not_cached_page feed_url
    
    get feed_url
    assert_cached_page feed_url
  end
  
  def test_feed_cache_expiration_on_comment_creation
    feed_url = "/feed.xml"
    
    get feed_url
    assert_cached_page feed_url
    
    create_comment
    assert_not_cached_page feed_url
    
    get feed_url
    assert_cached_page feed_url
  end
  
protected

  def create_talk
    post "/sessions/create", :email => users(:tiago).email, :password => "test"
    assert_equal users(:tiago).id, session[:user]
    
    assert_difference Talk, :count do
      post "/talks", :talk => {:title => "talk title", :description => "talk description"}
    end
  end

  def create_comment
    post "/sessions/create", :email => users(:tiago).email, :password => "test"
    assert_equal users(:tiago).id, session[:user]
    
    assert_difference Comment, :count do
      post "/comments", :comment => {:body => "exemplo de comment"}, :id => talks(:openid).id
    end
  end
  
  def create_post
    post "/admin/login", :admin => {:username => admins(:first).username, :password => admins(:first).password}
    
    assert_difference Post, :count do
      post "/admin/new_post", :post => {:title => "novo post", :body => "noticias fresquinhas"}
    end
  end
end
