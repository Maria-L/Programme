

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'sur_dode'

class SurDodeTest < Test::Unit::TestCase
  def test_sur_dode
    assert_in_delta(330.33, sur_dode(4.0), 0.01)    #Standart Case
    assert_equal(0.0, sur_dode(0.0))                #Border Case
    assert_raise(RuntimeError) {                    #Invalid Argument
      sur_dode -4.0
    }
    assert_raise(RuntimeError) {                    #Invalid Argument
      sur_dode 4
    }
  end
end
