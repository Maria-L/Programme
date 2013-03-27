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
require 'main2'

class Main2Test < Test::Unit::TestCase
  def test_foo
    assert_equal(Array[4],Array[1,2,3,4].all_without(Array[1,2,3]))
    assert_equal(Array[],Array[].all_without(Array[1,2,3]))
    assert_equal(Array[1,2,3,4],Array[1,2,3,4].all_without(Array[]))
    
#    assert_raise(RuntimeError) {
#      Array[1,2,3,4].all_without('a')
#    }
    
    assert_equal((1..5), Array[1,2,3,4,5].to_int_range)
    assert_equal("Err", Array[1,2,4].to_int_range)
    assert_equal("Err", Array[].to_int_range)
    
    assert_equal(Hash[1 => 2,3 => 4],Array[[1,2],[3,4]].to_hash)
    assert_equal(Hash[],Array[].to_hash)
    #assert_equal("Err",Array[[1,2,3]].to_hash)
  end
end


#Test{ Array[[1,2],[3,4]] -> Hash{1 => 2,3 => 4}, Array[] -> Hash{},
  #Array[[1,2,3]] -> Err}