require_relative'../Extensions/ext_pr1_v4'

class List
  def size_endrec
    size_endrec_helper 0
  end
  
  def size_endrec_helper akku
    if self.empty? then akku
    else self.rest.size_endrec_helper(akku + 1)
    end
  end
end

module Enumerable
  def first_index_for &block
    check_pre(block_given?)
    self.each_with_index {|a,i| if yield a then return i end}
    nil
  end
end

class Hash
  def without_keys_in enum
    #check_pre(enum.enum?)
    self.reduce(Hash.new) {|akku,elem| if not enum.include?(elem[0]) then akku[elem[0]] = elem[1] end;akku}
  end
end

class Array
  def add_int_comps
    check_pre(self.all? {|a| a.array? && 
          a.length == self[0].length && 
          a.all? {|a| a.int?}} && 
        (not self.empty?))
    self.reduce(Array.new(self[0].length,0)) {|a,b| a.add_array(b)}
  end
  
  def add_array array
    akku = Array.new
    self.each_with_index {|a,i| akku << (a + array[i])}; akku
  end
end
