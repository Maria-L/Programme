

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'vol_cyl'

class VolCylTest < Test::Unit::TestCase
  def test_vol_cyl
    assert_in_delta(141.37, vol_cyl(5.0, 3.0), 0.01)  #Standart case
    assert_equal(0, vol_cyl(0.0, 3.0))                #Border case (height == 0)
    assert_equal(0, vol_cyl(5.0, 0.0))                #Border case (radian == 0)
    
    
    
    assert_raise(RuntimeError) {                  #Invalid first Argument ( < 0)
      vol_cyl(-5.0, 3.0)
    }
    assert_raise(RuntimeError) {                  #Invalid second Argument ( < 0)
      vol_cyl(5.0, -3.0)
    }
    assert_raise(RuntimeError) {                  #Invalid second Argument ( < 0)
      vol_cyl(5, 3.0)
    }
    assert_raise(RuntimeError) {                  #Invalid second Argument ( < 0)
      vol_cyl(5.0, 3)
    }
  end
end
