# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'sets'

class SetsTest < Test::Unit::TestCase
  def test_sets
   #### superset? ####
   assert_equal(true,Set[1,2,3,4].superset?(Set[1,2,3]))
   assert_equal(true,Set[1,2,3].superset?(Set[1,2,3]))
   assert_equal(false,Set[1,2,3,4].superset?(Set[4,5,6]))
   
   assert_raise(RuntimeError){
     Set[1,2,3,4].superset?("a")
   }
   
    #### == ####
    assert_equal(true,Set[1,2,3,4]== Set[1,2,3,4])
    assert_equal(true,Set[2,1,3,4]== Set[1,2,3,4])
    assert_equal(false,Set[8,7,6,5]==Set[1,2,3,4])
    assert_equal(false,Set[1,2]==Set[1,2,3,4])
    assert_equal(false,Set[1,2]=="a")
    
  end
end