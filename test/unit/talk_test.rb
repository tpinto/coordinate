require File.dirname(__FILE__) + '/../test_helper'

class TalkTest < ActiveSupport::TestCase

  def test_validity
    t = Talk.new
    
    assert_not_valid t
    
    t.title = "nova talk"
    
    assert_not_valid t
    
    t.description = "lorem ipsum, la la la. muito lorem. muito ipsum"
    
    assert_not_valid t
    
    t.user = users(:tiago)
    
    #assert_not_valid t
    
    #t.event = events(:barcamppt08)
    
    assert_valid t
  end
end
