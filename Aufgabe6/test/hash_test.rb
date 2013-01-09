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
require 'hash'

class HashTest < Test::Unit::TestCase
  def test_hash
    
    ##### == #####
    
    assert_equal(true,Hash["a" =>1] == Hash["a" =>1])
    assert_equal(false,Hash["a" =>1,"b" =>2] == Hash["a" =>1])
    assert_equal(false,Hash["a" =>1] == Hash["a" =>2])
    assert_equal(false,Hash["a" =>1,"b" =>2] == Array[1,2])
    
    
    ##### add_counts_ #####
    
    assert_equal(Hash["a" => 2],Hash["a" => 1].add_counts_(Hash["a" => 1]))
    assert_equal(Hash["a" => 2, "b" => 2],Hash["a" =>1, "b" => 2].add_counts_(Hash["a" =>1]))
    assert_equal(Hash["a" => 1, "b" => 2, "c" => 3],Hash["a" =>1, "b" => 2].add_counts_(Hash["c" => 3]))
    
    assert_raise(RuntimeError) {
      Hash["a" => 1].add_counts_("a")
    }
  
  end
end

#Add the Values of the keys of both hashes
#
#add_counts_::= (a_hash) :: Hash -> Hash
#
#Test{ (Hash["a" =>1],Hash["a" =>1]) => Hash["a" => 2], (Hash["a" =>1, "b" => 2],Hash["a" =>1]) => Hash["a" => 2, "b" => 2],
#      (Hash["a" =>1, "b" => 2], Hash["c" => 3]) => Hash["a" => 1, "b" => 2, "c" => 3]
#      (Hash["a" =>1],"a") => Err}