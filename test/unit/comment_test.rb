require File.dirname(__FILE__) + '/../test_helper'

class CommentTest < ActiveSupport::TestCase

  def test_validity
    c = Comment.new
    
    assert_not_valid c
    
    c.body = "lorem ipsum"
    
    assert_not_valid c
    
    c.user = users(:tiago)
    
    assert_not_valid c
    
    c.talk = talks(:openid)
    
    assert_valid c
  end
  
  def test_converted_html
    c = Comment.new(  :user => users(:tiago),
                      :talk => talks(:openid),
                      :body => "teste\r\n\r\nomg *bold* lol")
                      
    c.save
    
    assert_equal %Q|<p>teste</p>\n<p>omg <strong>bold</strong> lol</p>|, c.body_html
  end
end
