require_relative'../Extensions/ext_pr1_v4'
class Object
  def list?; false end
  def enumerable?; false end
  def set?; false end
end

class List
  def list?; true end
  
  def reverse_endrec
    self.reverse_endrec_helper(List.new)
  end
  
  def reverse_endrec_helper list
    if self.empty? then list
    else self.rest.reverse_endrec_helper(list.prepend(self.first))
    end
  end
end

module Enumerable
  def enumerable?; true end
  
  def partition &block
    check_pre(block_given?)
    akku = Array.new(2,[])
    self.each {|a| if yield a then akku[0] << a else akku[1] << a end}
    akku
  end
end

class Hash
  def hash?; true end
  
  def invert_exact
    check_pre(self.keys.size == self.values.uniq.size)
    akku = Hash.new
    self.each {|key,value| akku[value] = key}
    akku
  end
end

class Set
  def set?; true end
  
  def symm_diff set
    check_pre(set.set?)
    self_c = self
    self.each{|a| if set.include?(a) then set = set.delete(a); self_c = self_c.delete(a) end}
    self_c.merge(set)
  end
end

set1 = Set[1,2,3]
set2 = Set[2,3,4]

p set1.symm_diff(set2)