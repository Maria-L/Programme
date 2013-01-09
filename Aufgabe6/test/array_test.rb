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

# To change this template, choose Tools | Templates
# and open the template in the editor.

$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'array'

class ArrayTest < Test::Unit::TestCase
  def test_array
    
    ##### elem? #####
    
    assert_equal(true,Array[1,2,3].elem?(2))
    assert_equal(false,Array[].elem?(2))
    
    
    ##### reverse_endrec #####
    
    assert_equal(Array[3,2,1],Array[1,2,3].reverse_endrec)
    assert_equal(Array[],Array[].reverse_endrec)
    
    ##### + #####
    
    assert_equal(Array[1,2,3,4],Array[1,2] + Array[3,4])
    assert_equal(Array[],Array[] + Array[])
    
    assert_raise(RuntimeError) {
      Array[1,2] + 'a'
    }
    
    ##### to_int_ #####
    
    assert_equal(123,Array[1,2,3].to_int_)
    assert_equal(0,Array[].to_int_)
    
    
    ##### even_only #####
    
    assert_equal(Array[],Array[].even_only)
    assert_equal(Array[2,4],Array[1,2,3,4].even_only)
    
    assert_raise(RuntimeError) {
      Array['a','b'].even_only
    }
    
    ##### flatten #####
    
    assert_equal(Array[],Array[].flatten)
    assert_equal(Array[3,4,1,2,3,4],Array[Array[Array[],3,4],Array[1,2,3,4]].flatten)
    
    
    ##### no_of_leaves_ #####
    
    assert_equal(0,Array[].no_of_leaves_)
    assert_equal(6,Array[Array[Array[],3,4],Array[1,2,3,4]].no_of_leaves_)
    
    
    ##### pairs_do_ #####
    
    assert_equal(Array[3,7],Array[[1,2],[3,4]].pairs_do_ {|a,b| a + b})
    assert_equal(Array[],Array[].pairs_do_ {|a,b| a + b})
    
    assert_raise(RuntimeError) {
      Array[[1,2],[3,4]].pairs_do_
    }
  end
end
