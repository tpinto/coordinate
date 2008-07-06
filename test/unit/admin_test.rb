require File.dirname(__FILE__) + '/../test_helper'

class AdminTest < ActiveSupport::TestCase

  def test_validity
    a = Admin.new
    
    assert_not_valid a
   
    a.username = "admin"
    
    assert_not_valid a
    
    a.password = "lalala"
    
    assert_valid a
  end
end
