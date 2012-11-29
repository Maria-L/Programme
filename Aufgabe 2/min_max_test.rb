
$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'min_max'

class MinMaxTest < Test::Unit::TestCase
  def test_min_max
    
    # Positiv Tests
    assert_equal(2, min_int(2,3))
    assert_equal(2, min_int(2,2))
    assert_equal(0, min_int(0,0))
    assert_equal(2, min_int(4,2))
    
    assert_equal(3, max_int(2,3))
    assert_equal(2, max_int(2,2))
    assert_equal(0, max_int(0,0))
    assert_equal(4, max_int(4,2))
    
    
    # Negativ Tests
    
    assert_raise(RuntimeError){
      min_int('3',5)
    }
    assert_raise(RuntimeError){
      min_int(3,'5')
    }
    assert_raise(RuntimeError){
      min_int(2.3,4)
    }
    
    
    assert_raise(RuntimeError){
      max_int('3',5)
    }
    assert_raise(RuntimeError){
      max_int(3,'5')
    }
    assert_raise(RuntimeError){
      max_int(2.3,4)
    }
    
  end
end
