# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'rekursionen'

class RekursionenTest < Test::Unit::TestCase
  def test_rekursionen
   #### sum ####
   ### positive Tests ###
   assert_equal(1,sum(1))
   assert_equal(0,sum(0))
   assert_equal(171,sum(18))

  ### negative Tests ###
  assert_raise(RuntimeError){
     sum("a")
   }
   assert_raise(RuntimeError){
     sum(-2)
   }

   #### pot ####
   ### positive Tests ###
   assert_equal(1,pot(5,0))
   assert_equal(5,pot(5,1))
   assert_equal(25,pot(5,2))
   ### negative Tests ###
   assert_raise(RuntimeError){
     pot(-5,0)
   }
   assert_raise(RuntimeError){
     pot(0,-5)
   }
   assert_raise(RuntimeError){
     pot("a",3)
   }
   assert_raise(RuntimeError){
     pot(3,"a")
   }

   #### fibo ####
   #### positive Tests ###
   assert_equal(0,fibo(0))
   assert_equal(1,fibo(1))
   assert_equal(8,fibo(6))
   ### negative Tests ###
   assert_raise(RuntimeError){
     fibo("a")
   }
   assert_raise(RuntimeError){
     fibo(-2)
   }
  end
end
