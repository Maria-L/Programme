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

class TranslateTest < Test::Unit::TestCase
  def test_translate
    
#    ###range1d###
#    assert_equal(Range1d[6,7],translate_1d(Range1d[5,6],1))
#    assert_equal(Range1d[4,5],translate_1d(Range1d[5,6],-1))
#    assert_equal(Range1d[0,0],translate_1d(Range1d[0,0],0))
#    assert_equal(Range1d[0,7],translate_1d(Range1d[-1,6],1))
#    
#    assert_raise(RuntimeError){
#      translate_1d(Range1d[5,'6'],0)
#    }
#    assert_raise(RuntimeError){
#      translate_1d(Range1d[5,6],'a')
#    }
#    assert_raise(RuntimeError){
#      translate_1d(Range2d[Range1d[2,3],Range1d[9,8]],0)
#    }
    
#    ###translate_union1d###
#    
#    assert_equal(Union1d[Union1d[Range1d[3,4], Range1d[5,6]], Range1d[7,8]],translate_union1d(Union1d[Union1d[Range1d[1,2], Range1d[3,4]], Range1d[5,6]], 2))
#    assert_equal(Union1d[Union1d[Range1d[-1,0], Range1d[1,2]], Range1d[3,4]],translate_union1d(Union1d[Union1d[Range1d[1,2], Range1d[3,4]], Range1d[5,6]], -2))
#    assert_equal(Union1d[Union1d[Range1d[1,2], Range1d[3,4]], Range1d[5,6]], translate_union1d(Union1d[Union1d[Range1d[1,2], Range1d[3,4]], Range1d[5,6]], 0))
#    
#    assert_raise(RuntimeError){
#      translate_union1d(Union1d[Union1d[Range1d[1,2], Range1d[3,4]], Range1d[5,6]], Range1d[7,8])
#    }
#    assert_raise(RuntimeError){
#      translate_union1d(Range1d[1,2], 0)
#    }
#    
#    ###translate_range2d###
#    
#    assert_equal(Range2d[Range1d[2,3], Range1d[5,6]], translate_range2d(Range2d[Range1d[1,2], Range1d[3,4]], Point2d[1,2]))
#    assert_equal(Range2d[Range1d[0,1], Range1d[1,2]], translate_range2d(Range2d[Range1d[1,2], Range1d[3,4]], Point2d[-1,-2]))
#    assert_equal(Range2d[Range1d[1,2], Range1d[3,4]], translate_range2d(Range2d[Range1d[1,2], Range1d[3,4]], Point2d[0,0]))
#    
#    assert_raise(RuntimeError){
#      translate_range2d(Range2d[Range1d[1,2], Range1d[3,4]], 'a')
#    }
#    assert_raise(RuntimeError){
#      translate_range2d(Range1d[1,2], Point2d[1,2])
#    }
#    
#    ###translate_union2d###
#    
#    assert_equal(Union2d[Union2d[Range2d[Range1d[3,4], Range1d[6,7]], Range2d[Range1d[8,9],Range1d[12,13]]], Range2d[Range1d[14,15], Range1d[18,19]]], translate_union2d(Union2d[Union2d[Range2d[Range1d[2,3], Range1d[4,5]], Range2d[Range1d[7,8],Range1d[10,11]]], Range2d[Range1d[13,14], Range1d[16,17]]], Point2d[1,2]))
#    assert_equal(Union2d[Union2d[Range2d[Range1d[1,2], Range1d[2,3]], Range2d[Range1d[6,7],Range1d[8,9]]], Range2d[Range1d[12,13], Range1d[14,15]]], translate_union2d(Union2d[Union2d[Range2d[Range1d[2,3], Range1d[4,5]], Range2d[Range1d[7,8],Range1d[10,11]]], Range2d[Range1d[13,14], Range1d[16,17]]], Point2d[-1,-2]))
#    assert_equal(Union2d[Union2d[Range2d[Range1d[2,3], Range1d[4,5]], Range2d[Range1d[7,8],Range1d[10,11]]], Range2d[Range1d[13,14], Range1d[16,17]]], translate_union2d(Union2d[Union2d[Range2d[Range1d[2,3], Range1d[4,5]], Range2d[Range1d[7,8],Range1d[10,11]]], Range2d[Range1d[13,14], Range1d[16,17]]], Point2d[0,0]))
#    
#    assert_raise(RuntimeError){
#      translate_union2d(Union2d[Union2d[Range2d[Range1d[2,3], Range1d[4,5]], Range2d[Range1d[7,8],Range1d[10,11]]], Range2d[Range1d[13,14], Range1d[16,17]]], 'a')
#    }
#    assert_raise(RuntimeError){
#      translate_union2d(Range1d, Point2d[1,2])
#    }
    
    ###translate###
    
    assert_equal(Range1d[6,7], translate(Range1d[5,6],1))
    assert_equal(Union1d[Union1d[Range1d[3,4], Range1d[5,6]], Range1d[7,8]], translate(Union1d[Union1d[Range1d[1,2], Range1d[3,4]], Range1d[5,6]], 2))
    assert_equal(Range2d[Range1d[3,4], Range1d[5,6]], translate(Range2d[Range1d[1,2], Range1d[3,4]], Point2d[2,2]))
    assert_equal(Union2d[Union2d[Range2d[Range1d[3,4], Range1d[6,7]], Range2d[Range1d[8,9],Range1d[12,13]]], Range2d[Range1d[14,15], Range1d[18,19]]], translate(Union2d[Union2d[Range2d[Range1d[2,3], Range1d[4,5]], Range2d[Range1d[7,8],Range1d[10,11]]], Range2d[Range1d[13,14], Range1d[16,17]]], Point2d[1,2]))
    
    assert_raise(RuntimeError){
      translate(Union2d[Range2d[Range1d[1,2], Range1d[3,4]]], 1)
    }
    assert_raise(RuntimeError){
      translate(Union1d[Range1d[1,2]], Point2d[1,2])
    }
  end
end
