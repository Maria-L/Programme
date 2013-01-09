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
require 'list'

class ListTest < Test::Unit::TestCase
  def test_list
    
    ##### reverse.endrec #####
    
    assert_equal(List[3,2,1],List[1,2,3].reverse_endrec)
    assert_equal(List[],List[].reverse_endrec)
    
    
    ##### + #####
    
    assert_equal(List[1,2,3,4],List[1,2] + List[3,4])
    assert_equal(List[],List[] + List[])
    
    assert_raise(RuntimeError) {
      List[1,2] + 'a'
    }
  end
end
