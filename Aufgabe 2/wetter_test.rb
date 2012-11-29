# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'wetter'

class WetterTest < Test::Unit::TestCase
  def test_wetter

    #### Positive Tests für zu_kalt? ####
    assert_equal(true,zu_kalt?(15))
    assert_equal(false, zu_kalt?(20))
    assert_equal(false, zu_kalt?(18))

    ##### Negative Tests für zu_kalt? #####
    assert_raise(RuntimeError){
      zu_kalt?('10')
    }
    assert_raise(RuntimeError){
      zu_kalt?(1.3)
    }

    #### Positive Tests für zu_warm? ####
    assert_equal(true,zu_warm?(26))
    assert_equal(false, zu_warm?(20))
    assert_equal(false, zu_warm?(25))

    ##### Negative Tests für zu_warm? #####

    assert_raise(RuntimeError){
      zu_warm?('10')
    }
    assert_raise(RuntimeError){
      zu_warm?(1.3)
    }

    #### Positive Tests für angenehm? ####
    assert_equal(true,angenehm?(18))
    assert_equal(true,angenehm?(25))
    assert_equal(false,angenehm?(13))
    assert_equal(true, angenehm?(23))
    
    ##### Negative Tests für angenehm? #####
    
    assert_raise(RuntimeError){
      angenehm?('10')
    }
    assert_raise(RuntimeError){
      angenehm?(10.3)
    }
    
    #### Positive Tests für unangenehm? ####
    assert_equal(false,unangenehm?(18))
    assert_equal(false,unangenehm?(23))
    assert_equal(true,unangenehm?(13))
    assert_equal(false, unangenehm?(23))
    
    ##### Negative Tests für unangenehm? #####
    
    assert_raise(RuntimeError){
      unangenehm? ('10')
    }
    assert_raise(RuntimeError){
      unangenehm?(10.3)
    }

  end
end
