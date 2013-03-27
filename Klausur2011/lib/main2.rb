require_relative'../Extensions/ext_pr1_v4'

class List
  def reverse_endrec
    reverse_endrec_helper(List[])
  end
  
  def reverse_endrec_helper akku
    if self.empty? then akku
    else self.rest.reverse_endrec_helper(akku.prepend(self.first))
    end
  end
end

module Enumerable
  def partition &block
    check_pre(block_given?)
    akku = [[],[]]
    self.each {|a| if yield a then akku[0] << a else akku[1] << a end};akku
  end
end

class Hash
  def invert_exact
    check_pre(self.bijection?)
    self.reduce(Hash.new) {|akku,elem| akku[elem[1]] = elem[0];akku}
  end
  
  def bijection?
    self.keys.size == self.values.uniq.size
  end
end

class Set
  def symm_diff set
    self.each {|a| if set.include?(a) then set = set.delete(a) else set.add(a) end}; set
  end
end
