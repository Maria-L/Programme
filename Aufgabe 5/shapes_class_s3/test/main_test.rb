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

class MainTest < Test::Unit::TestCase
  def test_main
    
    #####GRAPH_EQUAL#####

    
    assert_equal(false, Range1d[0,0].graph_equal?(0))
    assert_equal(true, Range1d[0,0].graph_equal?(Range1d[0,0]))
    assert_equal(false, Range1d[2,3].graph_equal?(Range1d[1,2]))
    assert_equal(true, Range2d[Range1d[0,0], Range1d[0,0]].graph_equal?(Range2d[Range1d[0,0], Range1d[0,0]]))
    assert_equal(false, Range2d[Range1d[0,0], Range1d[0,1]].graph_equal?(Range2d[Range1d[0,0],Range1d[0,0]]))
    assert_equal(true, Union1d[Union1d[Range1d[0,0], Range1d[1,2]], Range1d[2,3]].graph_equal?(Union1d[Union1d[Range1d[0,0], Range1d[1,2]], Range1d[2,3]]))
    assert_equal(false, Union1d[Union1d[Range1d[0,0], Range1d[1,2]], Range1d[2,4]].graph_equal?(Union1d[Union1d[Range1d[0,0], Range1d[1,2]], Range1d[2,3]]))
    assert_equal(true, Union2d[Union2d[Range2d[Range1d[2,3], Range1d[4,5]], Range2d[Range1d[7,8],Range1d[10,11]]], Range2d[Range1d[13,14], Range1d[16,17]]].graph_equal?(Union2d[Union2d[Range2d[Range1d[2,3], Range1d[4,5]], Range2d[Range1d[7,8],Range1d[10,11]]], Range2d[Range1d[13,14], Range1d[16,17]]]))
    assert_equal(false, Union2d[Union2d[Range2d[Range1d[2,3], Range1d[4,5]], Range2d[Range1d[7,8],Range1d[10,11]]], Range2d[Range1d[13,14], Range1d[16,18]]].graph_equal?(Union2d[Union2d[Range2d[Range1d[2,3], Range1d[4,5]], Range2d[Range1d[7,8],Range1d[10,11]]], Range2d[Range1d[13,14], Range1d[16,17]]]))
    
    assert_equal(false, Range1d[1,2].graph_equal_trans?(Range1d[0,0]))
    assert_equal(true, Range1d[0,0].graph_equal_trans?(Range1d[0,0]))
    assert_equal(true, Range1d[2,3].graph_equal_trans?(Range1d[1,2]))
    assert_equal(true, Range2d[Range1d[1,1], Range1d[1,1]].graph_equal_trans?(Range2d[Range1d[0,0], Range1d[0,0]]))
    assert_equal(false, Range2d[Range1d[1,1], Range1d[1,2]].graph_equal_trans?(Range2d[Range1d[0,0], Range1d[0,0]]))
    assert_equal(true, Union1d[Union1d[Range1d[1,1], Range1d[2,3]], Range1d[3,4]].graph_equal_trans?(Union1d[Union1d[Range1d[0,0], Range1d[1,2]], Range1d[2,3]]))
    assert_equal(false, Union1d[Union1d[Range1d[1,1], Range1d[2,3]], Range1d[3,5]].graph_equal_trans?(Union1d[Union1d[Range1d[0,0], Range1d[1,2]], Range1d[2,3]]))
    assert_equal(true, Union2d[Union2d[Range2d[Range1d[3,4], Range1d[5,6]], Range2d[Range1d[8,9],Range1d[11,12]]], Range2d[Range1d[14,15], Range1d[17,18]]].graph_equal_trans?(Union2d[Union2d[Range2d[Range1d[2,3], Range1d[4,5]], Range2d[Range1d[7,8],Range1d[10,11]]], Range2d[Range1d[13,14], Range1d[16,17]]]))
    assert_equal(false, Union2d[Union2d[Range2d[Range1d[3,4], Range1d[5,6]], Range2d[Range1d[8,9],Range1d[11,12]]], Range2d[Range1d[14,15], Range1d[17,19]]].graph_equal_trans?(Union2d[Union2d[Range2d[Range1d[2,3], Range1d[4,5]], Range2d[Range1d[7,8],Range1d[10,11]]], Range2d[Range1d[13,14], Range1d[16,17]]]))
    assert_equal(false, Range1d[0,0].graph_equal_trans?("a"))
    
    
    ###range1d###
    assert_equal(Range1d[6,7],Range1d[5,6].translate(1))
    assert_equal(Range1d[4,5],Range1d[5,6].translate(-1))
    assert_equal(Range1d[0,0],Range1d[0,0].translate(0))
    assert_equal(Range1d[0,7],Range1d[-1,6].translate(1))
    
    assert_raise(RuntimeError){
      Range1d[5,6].translate('a')
    }
  
    
    ###translate_union1d###
    
    assert_equal(Union1d[Union1d[Range1d[3,4], Range1d[5,6]], Range1d[7,8]],Union1d[Union1d[Range1d[1,2], Range1d[3,4]], Range1d[5,6]].translate(2))
    assert_equal(Union1d[Union1d[Range1d[-1,0], Range1d[1,2]], Range1d[3,4]],Union1d[Union1d[Range1d[1,2], Range1d[3,4]], Range1d[5,6]].translate(-2))
    assert_equal(Union1d[Union1d[Range1d[1,2], Range1d[3,4]], Range1d[5,6]], Union1d[Union1d[Range1d[1,2], Range1d[3,4]], Range1d[5,6]].translate(0))
    
    assert_raise(RuntimeError){
      Union1d[Union1d[Range1d[1,2], Range1d[3,4]], Range1d[5,6]].translate(Range1d[7,8])
    }
  
    ###translate_range2d###
    
    assert_equal(Range2d[Range1d[2,3], Range1d[5,6]], Range2d[Range1d[1,2], Range1d[3,4]].translate(Point2d[1,2]))
    assert_equal(Range2d[Range1d[0,1], Range1d[1,2]], Range2d[Range1d[1,2], Range1d[3,4]].translate(Point2d[-1,-2]))
    assert_equal(Range2d[Range1d[1,2], Range1d[3,4]], Range2d[Range1d[1,2], Range1d[3,4]].translate(Point2d[0,0]))
    
    assert_raise(RuntimeError){
      Range2d[Range1d[1,2], Range1d[3,4]].translate('a')
    }
  
    
    ###translate_union2d###
    
    assert_equal(Union2d[Union2d[Range2d[Range1d[3,4], Range1d[6,7]], Range2d[Range1d[8,9],Range1d[12,13]]], Range2d[Range1d[14,15], Range1d[18,19]]], Union2d[Union2d[Range2d[Range1d[2,3], Range1d[4,5]], Range2d[Range1d[7,8],Range1d[10,11]]], Range2d[Range1d[13,14], Range1d[16,17]]].translate(Point2d[1,2]))
    assert_equal(Union2d[Union2d[Range2d[Range1d[1,2], Range1d[2,3]], Range2d[Range1d[6,7],Range1d[8,9]]], Range2d[Range1d[12,13], Range1d[14,15]]], Union2d[Union2d[Range2d[Range1d[2,3], Range1d[4,5]], Range2d[Range1d[7,8],Range1d[10,11]]], Range2d[Range1d[13,14], Range1d[16,17]]].translate(Point2d[-1,-2]))
    assert_equal(Union2d[Union2d[Range2d[Range1d[2,3], Range1d[4,5]], Range2d[Range1d[7,8],Range1d[10,11]]], Range2d[Range1d[13,14], Range1d[16,17]]], Union2d[Union2d[Range2d[Range1d[2,3], Range1d[4,5]], Range2d[Range1d[7,8],Range1d[10,11]]], Range2d[Range1d[13,14], Range1d[16,17]]].translate(Point2d[0,0]))
    
    assert_raise(RuntimeError){
      Union2d[Union2d[Range2d[Range1d[2,3], Range1d[4,5]], Range2d[Range1d[7,8],Range1d[10,11]]], Range2d[Range1d[13,14], Range1d[16,17]]].translate('a')
    }
    
    
    #####BOUNDS#####
    
    assert_equal(Range1d[1,2], Range1d[1,2].bounds())
    assert_equal(Range1d[0,0], Range1d[0,0].bounds())
    assert_equal(Range2d[Range1d[1,2],Range1d[2,3]], Range2d[Range1d[1,2],Range1d[2,3]].bounds())
    assert_equal(Range2d[Range1d[0,0],Range1d[0,0]], Range2d[Range1d[0,0],Range1d[0,0]].bounds())
    assert_equal(Range1d[1,3], Union1d[Range1d[1,2],Range1d[2,3]].bounds())
    assert_equal(Range1d[0,0], Union1d[Range1d[0,0],Range1d[0,0]].bounds())
    assert_equal(Range2d[Range1d[1,10],Range1d[3,12]], Union2d[Union2d[Range2d[Range1d[1,2], Range1d[3,4]], Range2d[Range1d[5,6], Range1d[7,8]]],Range2d[Range1d[9,10], Range1d[11,12]]].bounds())
    assert_equal(Range2d[Range1d[0,0],Range1d[0,0]], Union2d[Union2d[Range2d[Range1d[0,0], Range1d[0,0]], Range2d[Range1d[0,0], Range1d[0,0]]],Range2d[Range1d[0,0], Range1d[0,0]]].bounds())
    
    
    #####IN?#####
    
    assert_equal(true, Range1d[1,2].in?(1))
    assert_equal(false, Range1d[2,3].in?(1))
    assert_equal(true, Range1d[0,0].in?(0))
    assert_equal(true, Range2d[Range1d[-1,5],Range1d[-1,3]].in?(Point2d[0,0]))
    assert_equal(false, Range2d[Range1d[1,5],Range1d[1,3]].in?(Point2d[0,0]))
    assert_equal(true, Range2d[Range1d[0,0],Range1d[0,0]].in?(Point2d[0,0]))
    assert_equal(true, Union1d[Range1d[1,2],Range1d[2,3]].in?(1))
    assert_equal(false, Union1d[Range1d[1,2],Range1d[2,3]].in?(0))
    assert_equal(true, Union1d[Range1d[0,0],Range1d[0,0]].in?(0))
    assert_equal(true, Union2d[Range2d[Range1d[1,2],Range1d[2,3]],Union2d[Range2d[Range1d[1,2],Range1d[2,3]],Range2d[Range1d[1,3],Range1d[2,6]]]].in?(Point2d[1,2]))
    assert_equal(false, Union2d[Range2d[Range1d[1,2],Range1d[2,3]],Union2d[Range2d[Range1d[1,2],Range1d[2,3]],Range2d[Range1d[1,3],Range1d[2,6]]]].in?(Point2d[-1,-2]))
    assert_equal(true, Union2d[Range2d[Range1d[0,0],Range1d[0,0]],Union2d[Range2d[Range1d[0,0],Range1d[0,0]],Range2d[Range1d[0,0],Range1d[0,0]]]].in?(Point2d[0,0]))

    

    
  end
end
