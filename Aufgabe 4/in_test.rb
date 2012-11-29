# To change this template, choose Tools | Templates
# and open the template in the editor.

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

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'main'

class InTest < Test::Unit::TestCase
  def test_in?
    assert_equal(false, in?(Point2d[1,2], Range1d[1,2]))
    assert_equal(true, in?(1,Range1d[1,2]))
    assert_equal(false, in?(1,Range1d[2,3]))
    assert_equal(true, in?(0,Range1d[0,0]))
    assert_equal(true, in?(Point2d[0,0],Range2d[Range1d[-1,5],Range1d[-1,3]]))
    assert_equal(false, in?(Point2d[0,0],Range2d[Range1d[1,5],Range1d[1,3]]))
    assert_equal(true, in?(Point2d[0,0],Range2d[Range1d[0,0],Range1d[0,0]]))
    assert_equal(true, in?(1,Union1d[Range1d[1,2],Range1d[2,3]]))
    assert_equal(false, in?(0,Union1d[Range1d[1,2],Range1d[2,3]]))
    assert_equal(true, in?(0,Union1d[Range1d[0,0],Range1d[0,0]]))
    assert_equal(true, in?(Point2d[1,2],Union2d[Range2d[Range1d[1,2],Range1d[2,3]],Union2d[Range2d[Range1d[1,2],Range1d[2,3]],Range2d[Range1d[1,3],Range1d[2,6]]]]))
    assert_equal(false, in?(Point2d[-1,-2],Union2d[Range2d[Range1d[1,2],Range1d[2,3]],Union2d[Range2d[Range1d[1,2],Range1d[2,3]],Range2d[Range1d[1,3],Range1d[2,6]]]]))
    assert_equal(true, in?(Point2d[0,0],Union2d[Range2d[Range1d[0,0],Range1d[0,0]],Union2d[Range2d[Range1d[0,0],Range1d[0,0]],Range2d[Range1d[0,0],Range1d[0,0]]]]))
    
    assert_raise(RuntimeError){
      in?(1,"a")
    }
    assert_raise(RuntimeError){
      in?(Point2d[1,2],1)
    }
  end
end
