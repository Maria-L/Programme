
$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'larger_sum_square'

class TwoBiggestTest < Test::Unit::TestCase
  def test_larger_sum_square
    
    #### Positive Tests ####
    assert_equal(52, larger_sum_square(2,4,6))
    assert_equal(52, larger_sum_square(4,2,6))
    assert_equal(52, larger_sum_square(6,4,2))
    assert_equal(8, larger_sum_square(2,2,2))
    assert_equal(20, larger_sum_square(2,2,4))
    assert_equal(40, larger_sum_square(-4,-2,6))
      
    ##### Negative Tests #####
    assert_raise(RuntimeError) {
      larger_sum_square('2',4,6)
    }
    assert_raise(RuntimeError) {
      larger_sum_square(2,'4',6)
    }
    assert_raise(RuntimeError) {
      larger_sum_square(2,4,'6')
    }
    assert_raise(RuntimeError) {
      larger_sum_square(2.1,4,6)
    }
    assert_raise(RuntimeError) {
      larger_sum_square(2,4.1,6)
    }
    assert_raise(RuntimeError) {
      larger_sum_square(2,4,6.1)
    }
  end
end
