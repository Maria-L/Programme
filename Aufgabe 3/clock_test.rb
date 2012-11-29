# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'clock'

class Clock_test < Test::Unit::TestCase
  def test_clock
    #### Positive Tests ####
    assert_equal([15, 12, 31, ""], clock_suc(15, 12, 30))
    assert_equal([0, 0, 0, ""], clock_suc(23, 59, 59))
    
    ##### Negative Tests #####
    assert_raise(RuntimeError) {
      clock_suc('15', 12, 30)
    }
    assert_raise(RuntimeError) {
      clock_suc(15, '12', 30)
    }
    assert_raise(RuntimeError) {
      clock_suc(15, 12, '30')
    }
    
    
    #### Positive Tests ####
    assert_equal([15, 12, 29, ""], clock_pre(15, 12, 30))
    assert_equal([23, 59, 59, ""], clock_pre(0, 0, 0))
    
    ##### Negative Tests #####
    assert_raise(RuntimeError) {
      clock_pre('15', 12, 30)
    }
    assert_raise(RuntimeError) {
      clock_pre(15, '12', 30)
    }
    assert_raise(RuntimeError) {
      clock_pre(15, 12, '30')
    }
  end
end
