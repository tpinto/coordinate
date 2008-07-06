require File.dirname(__FILE__) + '/../test_helper'

class PostTest < ActiveSupport::TestCase

  def test_validity
    p = Post.new
    
    assert_not_valid p
    
    p.title = "testes, muitos testes"
    
    assert_not_valid p
    
    p.body = "lorem ipsum, la la la"
    
    assert_valid p
  end
end
