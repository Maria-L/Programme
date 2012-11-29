# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'intervall'

class IntervallTest < Test::Unit::TestCase
  def test_intervall

    # Positive Tests

    assert_equal(true,within?(3,1,8))
    assert_equal(true,within?(3,-1,8))
    assert_equal(true,within?(3,3,5))
    assert_equal(true,within?(5,3,5))
    assert_equal(true,within?(3,3,3))
    assert_equal(false,within?(3,4,7))
    

    # Negative Tests

    assert_raise(RuntimeError){
      within?('3',3,5)
    }
    assert_raise(RuntimeError){
      within?(3,'3',5)
    }
    assert_raise(RuntimeError){
      within?(3,3,'5')
    }
    assert_raise(RuntimeError){
      within?(2.1,1,5)
    }   
    assert_raise(RuntimeError){
      within?(2,1.8,5)
    }
    assert_raise(RuntimeError){
      within?(2,1,5.6)
    }
    assert_raise(RuntimeError){
      within?(3,3,1)
    }
    
  end
end