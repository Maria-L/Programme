# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
module Test
  module Unit
    module Assertions
      class AssertionMessage
        class << self
          def ensure_diffable_string(string)
            string = string.dup.force_encoding("ASCII-8BIT") if string.respond_to?(:encoding) and 
              string.encoding.respond_to?(:ascii_compatible?) and
              !string.encoding.ascii_compatible?
            string
          end
        end
      end
    end
  end  
end
require 'simple_clock_forward'

class SimpleClockForwardTest < Test::Unit::TestCase
  def test_simple_clock_forward
    assert_equal([13, 14, 15], simple_clock_forward(13, 14, 15))      #Standart case
    assert_equal([1, 14, 15], simple_clock_forward(1, 14, 15))      
    assert_equal([2, 10, 12], simple_clock_forward(26,10,12))         #tests wrap-around to zero
    assert_equal([0, 0, 0], simple_clock_forward(0, 0, 0))
    assert_raise(RuntimeError) {                                      #Invalid first argument
      simple_clock_forward(-1, 2, 3)
    }
    assert_raise(RuntimeError) {                                      #Invalid second argument
      simple_clock_forward(1, -2, 3)
    }
    assert_raise(RuntimeError) {                                      #Invalid third argument
      simple_clock_forward(1, 2, -3)
    }
    assert_raise(RuntimeError) {                                      #Invalid first argument
      simple_clock_forward(1.1, 2, 3)
    }
    assert_raise(RuntimeError) {                                      #Invalid second argument
      simple_clock_forward(1, 2.1, 2)
    }
    assert_raise(RuntimeError) {                                      #Invalid third argument
      simple_clock_forward(1, 2, 3.1)
    }
  end
end
