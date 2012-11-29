

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
require 'clock_forward'

class ClockForwardTest < Test::Unit::TestCase
  def test_clock_forward
    assert_equal([13, 14, 15, ""], clock_forward(13, 14, 15, 1))      #Standart 24h case
    assert_equal([1, 14, 15, "pm"], clock_forward(13, 14, 15, 0))     #Standart 12h case
    assert_equal([1, 14, 15, "am"], clock_forward(1, 14, 15, 0))      #Standart 12h case
    assert_equal([2, 10, 12, "am"], clock_forward(26,10,12,0))        #tests wrap-around to zero
    assert_equal([0, 0, 0, "am"], clock_forward(0, 0, 0, 0))
    assert_raise(RuntimeError) {                                      #Invalid first argument
      clock_forward(-1, 2, 3, 1)
    }
    assert_raise(RuntimeError) {                                      #Invalid second argument
      clock_forward(1, -2, 3, 1)
    }
    assert_raise(RuntimeError) {                                      #Invalid third argument
      clock_forward(1, 2, -3, 1)
    }
    assert_raise(RuntimeError) {                                      #Invalid first argument
      clock_forward(1.1, 2, 3, 1)
    }
    assert_raise(RuntimeError) {                                      #Invalid second argument
      clock_forward(1, 2.1, 2, 1)
    }
    assert_raise(RuntimeError) {                                      #Invalid third argument
      clock_forward(1, 2, 3.1, 1)
    }
    assert_raise(RuntimeError) {                                      #Invalid fourth argument
      clock_forward(1, 2, 3, 5)
    }
    assert_raise(RuntimeError) {                                      #Invalid fourth argument
      clock_forward(1, 2, 3, 1.0)
    }
  end
end
