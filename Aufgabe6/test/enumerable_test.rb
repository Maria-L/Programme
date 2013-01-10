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
require 'enumerable'

class EnumerableTest < Test::Unit::TestCase
  def test_enumerable
    
    ##### to_arr #####
    
    assert_equal(Array[[1,2],[3,4]],Hash[1,2,3,4].to_arr)
    assert_equal(Array[],Hash[].to_arr)
    
    
    ##### map_ #####
    
    assert_equal(Array[2,3,4,5],Array[1,2,3,4].map_ {|a| a + 1})
    assert_equal(Array[],Array[].map_ {|a| a + 1})
    
    assert_raise(RuntimeError) {
      Array[].map_
    }
    
    ##### any_? #####
    
    assert_equal(true,Array[1,2,3,4].any_? {|a| a < 5})
    assert_equal(false,Array[1,2,3,4].any_? {|a| a < 1})
    assert_equal(false,Array[].any_? {|a| a < 5})
    
    assert_raise(RuntimeError) {
      Array[1,2,3,4].any_?
    }
    
    ##### freq_count #####
    
    assert_equal(Hash[1 => 1,2 => 2,3 => 1],Array[1,2,2,3].freq_count_)
    assert_equal(Hash[],List[].freq_count_)
    
    
    ##### max_ #####
    assert_equal("Hund",Array["Hund","Katze","blaaaaaaa"].max_)
    assert_equal("blaaaaaaa",Array["Hund","Katze","blaaaaaaa"].max_ {|a,b| a.length <=> b.length})
  end
end
