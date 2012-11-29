# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'main'

class BoundsTest < Test::Unit::TestCase
  def test_bounds
    assert_equal(Range1d[1,2], bounds(Range1d[1,2]))
    assert_equal(Range1d[0,0], bounds(Range1d[0,0]))
    assert_equal(Range2d[Range1d[1,2],Range1d[2,3]], bounds(Range2d[Range1d[1,2],Range1d[2,3]]))
    assert_equal(Range2d[Range1d[0,0],Range1d[0,0]], bounds(Range2d[Range1d[0,0],Range1d[0,0]]))
    assert_equal(Range1d[1,3], bounds(Union1d[Range1d[1,2],Range1d[2,3]]))
    assert_equal(Range1d[0,0], bounds(Union1d[Range1d[0,0],Range1d[0,0]]))
    assert_equal(Range2d[Range1d[1,10],Range1d[3,12]], bounds(Union2d[Union2d[Range2d[Range1d[1,2], Range1d[3,4]], Range2d[Range1d[5,6], Range1d[7,8]]],Range2d[Range1d[9,10], Range1d[11,12]]]))
    assert_equal(Range2d[Range1d[0,0],Range1d[0,0]], bounds(Union2d[Union2d[Range2d[Range1d[0,0], Range1d[0,0]], Range2d[Range1d[0,0], Range1d[0,0]]],Range2d[Range1d[0,0], Range1d[0,0]]]))
    
    assert_raise(RuntimeError){
      bounds("a")
    }
  end
end
