
require_relative'../Extensions/ext_pr1_v4'

class List
  def size_endrec
    self.size_endrec_helper(0)
  end
  
  def size_endrec_helper(n)
    if self.empty? then n
    else self.rest.size_endrec_helper(n + 1)
    end
  end
end

module Enumerable
  def first_index
    check_pre(block_given?)
    self.each_with_index {|elem,i| if yield elem then return i end}
  end
end

class Hash
  def without_keys_in(enum)
    check_pre(enum.is_a?(Enumerable))
    akku = Hash.new
    self.each {|key,elem| if not enum.any? {|a| a == key} then akku[key] = elem end}
    akku
  end
  
  def without_keys_in(enum)
#    self.reduce (Hash.new) {|akku,elem| 
#      if not enum.include?(elem[0])
#        akku[elem[0]] = self[elem[0]]
#      end
#      akku
#    }
    self.reduce (Hash.new) {|akku,(key,value)| 
      if not enum.include?(key)
        akku[key] = self[key]
      end
      akku
    }
  end
end

hash = Hash[1,2,3,4,5,6,7,8]
enum = Array[1,2,3,4]

p hash.without_keys_in(enum)

class Array
  def add_int_comps
    check_pre(self.all? {|a| a.is_a?(Array)} && 
        self.all? {|a| self[0].length == a.length})
    self.reduce {|a,b| a.add_arrays(b)}
  end
  
  def add_arrays(array)
    i = 0
    akku = Array.new
    while i < self.length
      akku << (self[i] + array[i])
      i = i + 1
    end
    akku
  end
end
