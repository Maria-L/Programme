

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'vol_cube'

class VolCubeTest < Test::Unit::TestCase
  def test_vol_cube
    
    ########## Positive Tests ##########
    assert_equal(12, vol_cube(4, 2, 2))   #General Test
    assert_equal(0, vol_cube(4, 4, 3))    #Edge Test for x = y
    
    
    ########## Negative Tests ##########
    assert_raise(RuntimeError) {          #Invalid first Argument (x < y)
      vol_cube(2, 4, 3)
    }
    assert_raise(RuntimeError) {          #Invalid third Argument (n < 0)
      vol_cube(4, 2, -1)
    }
    assert_raise(RuntimeError) {          #Invalid third Argument (floating point)
      vol_cube(4, 2, 2.4)
    }
    assert_raise(RuntimeError) {          #Invalid first Argument (x < 0)
      vol_cube(-4, 2, 2)
    }
    assert_raise(RuntimeError) {          #Invalid second Argument (y < 0)
      vol_cube(4, -2, 2)
    }
  end
end
