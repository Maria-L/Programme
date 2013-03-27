require_relative'../Extensions/ext_pr1_v4'

module Enumerable
  #Tests, whether an Element is contained in an Enumerable
  #
  #include_? ::= (self,obj) :: Enumerable x Any => Bool
  #
  #Test { (Array[1,2,3],2) => true, (Hash[1,2,3,4],[1,2]) => true,
  #(Set[1,2,3,4],5) => false}
  #
  def include_? obj
    self.each {|a| if a == obj then return true end}
    false
  end
  
  #Tests, whether any Element of an Enumerable evaluates to true in a given Block
  #
  #Enum#any_? ::= Enumerable(X) x (X -> Bool) -> Bool
  #
  def any_? &block
    check_pre(block_given?)
    self.each {|a| if yield a then return true end}
    false
  end
  
  #Tests whether all Elements evaluate to true with the given predicate
  #
  #all_? ::= Enumerable(X) x (X -> Bool) -> Bool
  #
  def all_? &block
    check_pre(block_given?)
    self.each {|a| if not yield a then return false end}
    true
  end
  
  #Conversts an Enumerable to an Array
  #
  #to_a_ ::= (self) :: Enumerable => Array
  #
  def to_a_
    self.reduce(Array.new) {|a,b| a << b}
  end
  
  #Converts any Enumerable into a Set
  #
  #to_set_ ::= (self) :: Enumerable => Set
  #
  def to_set_
    self.reduce(Set.new) {|a,b| a.add(b)}
  end
  
  #Conversts an Enumerable to an Array in which every Element of the Enumerable which ain't fit the given block is deleted
  #
  #Enum#select_ ::= Enumerable(X) -> (X -> Bool) => Array
  #
  def select_ &block
    check_pre(block_given?)
    self.reduce(Array.new) {|a,b| if yield b then a << b else a end}
  end
  
  #Converts an Enumerable to an Array which has no Elements left, which fit the given block.
  #
  #Enum#reject_ ::= Enumerable(X) x (X -> Bool) => Array
  #
  def reject_ &block
    check_pre(block_given?)
    self.reduce(Array.new) {|a,b| if yield b then a else a << b end}
  end
  
  #Returns an Array in which every Element is mapped with the given block
  #
  #map_ ::= Enumerable(X) -> (X -> Bool) => Array
  #
  def map_ &block
    check_pre(block_given?)
    self.reduce(Array.new) {|a,b| a << (yield b)}
  end
  
  #  def reduce_ &block
  #    self.each {|a|}
  #  end
end

class Array
  def empty_?
    if self == [] then true else false end
  end
  
  def include_? elem
    self.each {|a| if a == elem then return true end}
    false
  end
  
  def size_
    if self.empty? 0 
    else 1 + self.drop(1).size_
    end
  end
  
  def first_
    if self.empty? then nil
    else self[0]
    end
  end
  
  def last_
    if self.empty? then nil
    else self[-1]
    end
  end
  
  def each_ &block
    i = 0
    while i < self.length 
      yield self[i]
      i += 1
    end
    self
  end
  
  def each_with_index_ &block
    i = 0
    while i < self.length
      yield self[i], i
      i += 1
    end
    self
  end
  
  #Array#each_slice_ ::= (n) :: Enumerable(X) x Integer x (X -> Any) -> Enumerable :::: n > 0
  def each_slice_ n, &block
    i = 0
    temp = self
    while i  < self.length
      yield temp.first(n)
      temp = temp.drop(n)
      i += n
    end
    self
  end
  
  #Array#each_cons_ ::= (n) :: Enumerable(X) x Integer x (X -> Any) -> Array :::: n > 0
  def each_cons_ n, &block
    i = 0
    temp = self
    while i < self.length - n
      yield temp.first(n)
      temp = temp.drop(1)
      i += 1
    end
    self
  end
  
  def + array
    akku = self
    array.reduce(akku) {|a,b| a << b}
  end
  
  def reverse_
#    if self.empty? then []
#    else self.drop(1).reverse_.concat([self[0]])
#    end
    i = 0
    akku = Array.new
    while i < self.length
      akku << self[-i - 1]
      i += 1
    end
    akku
  end
  
  def equality array
    if    self.empty? && array.empty? then true
    elsif self[0] == array[0]         then self.drop(1).equality(array.drop(1))
    else  false
    end
  end
  
  def spaceship array
    if self == [] and array == []           then 0
    elsif self == []                        then -1
    elsif array == [] || self[0] > array[0] then 1
    elsif self[0] < array[0]                then -1
    else self.drop(1).spaceship(array.drop(1))
    end
  end
  
  def concat_ array
    temp = self
    array.reduce(temp) {|a,b| a << b}
    temp
  end
end

class Hash
  def has_key_? obj
    self.any? {|key,value| key == obj}
  end
  
  def has_value_? obj
    self.any? {|key,value| value == obj}
  end
  
  def size_
    self.keys.size
  end
  
  def each_ &block
    i = 0
    while i < self.keys.size
      yield [self.keys[i],self[self.keys[i]]]
      i = i + 1
    end
    self
  end
  
  def each_key_ &block
    i = 0
    while i < self.keys.size
      yield self.keys[i]
      i = i + 1
    end
    self.keys
  end
  
  def to_set_
    akku = Set.new
    self.each {|key,value| akku.add([key,value])}
  end
  
  def equality hash
    hash.keys.size == self.keys.size &&
      self.all? {|key,value| hash.has_key?(key) && hash[key] == value}
  end
  
  def keys_
    self.reduce(Array.new) {|a,b| a << b[0]}
  end
  
  def values_
    self.reduce(Array.new) {|a,b| a << b[1]}
  end
  
  def to_a_ 
    self.reduce(Array.new) {|a,b| a << b}
  end
  
  def to_set_
    self.reduce(Set.new) {|a,b| a.add(b)}
  end
end


class Set
  def set?; true end
  
  def include_? obj
    self.each {|a| if a == obj then return true end}
    false
  end
  
  def equality obj
    if obj.set? && self.length == obj.length && self.all? {|a| obj.include?(a)} then true else false end
  end
  
  def subset_? obj
    if obj.set? && self.all? {|a| obj.include?(a)} then true else false end
  end
  
  def superset_? obj
    if obj.set? && obj.all? {|a| self.include?(a)} then true else false end
  end
  
  def size_
    self.reduce(0) {|a,b| a + 1}
  end
  
  def add_ enum
    akku = self
    enum.each {|a| akku = akku.add(a)}; akku
  end
end


set1 = Set[1,2,3]
set2 = Set[3,1,2]

p set1 == set2