require_relative '../Extensions/ext_pr1_v4'

#Calculates the sum from zero to n
#
#sum ::= (n) :: Int => Int :::: n >= 0
#
#Test {
#(0) => 0, (3) => 6,
#(-3) => Err, ('a') => Err}
#

def sum n
  check_pre(n.int? && n >= 0)
  if    n == 0  then 0
  elsif n > 0   then sum(n-1) + n
  else check_pre(false)
  end
end

#Calculates x to the power of n
#
#pot ::= (x,n) :: Int x Int => Int :::: n >= 0
#
#Test {
#(0,0) => 1, (5,1) => 5, (2,3) => 4,
#(0,-1) => Err, ('a',1) => Err}
#
def pot x, n
  check_pre(n.int? && n >= 0 && x.int?)
  if    n == 0  then 1
  elsif n > 0   then x * pot(x,(n-1))
  else  check_pre(false)
  end
end

#Calculates the n.th number of the Fibonacci-Row (including zero)
#
#fibo ::= (n) :: Int => Int :::: n >=0
#
#Test {
#(0) => 0, (3) => 2,
#('a') => Err}
#
def fibo n
  check_pre(n.int? && n >= 0)
  if    n == 0  then 0
  elsif n == 1  then 1
  elsif n > 1   then fibo(n-1) + fibo(n-2)
  else check_pre(false)
  end
end

#Calculates the sum from zero to n
#
#sum_ ::= (n) :: Int => Int :::: n >= 0
#
#Test {
#(0) => 0, (3) => 6,
#(-3) => Err, ('a') => Err}
#
def sum_ n
  check_pre(n.int? && n >= 0)
  sum_helper(n, 0)
end

def sum_helper n, akku
  if    n == 0  then akku
  elsif n > 0   then sum_helper((n-1), (akku + n))
  else check_pre(false)
  end
end

#Calculates x to the power of n
#
#pot_ ::= (x,n) :: Int x Int => Int :::: n >= 0
#
#Test {
#(0,0) => 1, (5,1) => 5, (2,3) => 4,
#(0,-1) => Err, ('a',1) => Err}
#
def pot_ x, n
  check_pre(n.int? && n >= 0 && x.int?)
  pot_helper(x,n,1)
end

def pot_helper x, n, akku
  if    n == 0  then akku
  elsif n > 0   then pot_helper(x, (n-1), (akku * x))
  else check_pre(false)
  end
end

#Calculates the n.th number of the Fibonacci-Row (including zero)
#
#fibo ::= (n) :: Int => Int :::: n >=0
#
#Test {
#(0) => 0, (3) => 2,
#('a') => Err}
#
def fibo_ n
  fibo_helper n, 0, 0
end

def fibo_helper n, akku1, akku2
  if    n == 0  then akku1 + akku2
  elsif n == 1  then akku1 + akku2 + 1
  elsif n > 1   then fibo_helper()
  else check_pre(false)
  end
end

#Calculates the sum from zero to n
#
#sum_it ::= (n) :: Int => Int :::: n >= 0
#
#Test {
#(0) => 0, (3) => 6,
#(-3) => Err, ('a') => Err}
#
def sum_it n
  check_pre(n.int? && n >= 0)
  akku = 0
  while n > 0
    akku = akku + n
    n = n - 1
  end
  akku
end

#Calculates x to the power of n
#
#pot_it ::= (x,n) :: Int x Int => Int :::: n >= 0
#
#Test {
#(0,0) => 1, (5,1) => 5, (2,3) => 4,
#(0,-1) => Err, ('a',1) => Err}
#
def pot_it x, n
  check_pre(n.int? && n >= 0 && x.int?)
  akku = 1
  while n > 1
    akku = akku * x
    n = n - 1
  end
  akku
end

#Calculates the sum from zero to n
#
#sum_red ::= (n) :: Int => Int :::: n >= 0
#
#Test {
#(0) => 0, (3) => 6,
#(-3) => Err, ('a') => Err}
#
def sum_red n
  check_pre(n.int? && n >= 0)
  Array(1..n).reduce(){|a,b| a + b}
end

#Calculates x to the power of n
#
#pot_red ::= (x,n) :: Int x Int => Int :::: n >= 0
#
#Test {
#(0,0) => 1, (5,1) => 5, (2,3) => 4,
#(0,-1) => Err, ('a',1) => Err}
#
def pot_red x, n
  check_pre(n.int? && n >= 0 && x.int?)
  (1..n).reduce() {|a,b| x * x}
end

class Object
  def array?; false end
  def set?; false end
end


class List
  #Determines the inverse of a List
  #
  #reverse_endrec ::= (self) :: List => List
  #
  #Test {
  #List[1,2,3] => List[3,2,1], List[] => List[]}
  #
  def reverse_endrec
    self.reverse_endrec_helper List[]
  end
  
  def reverse_endrec_helper akku
    check_pre(akku.list?)
    if self.empty? then akku
    else (self.rest).reverse_endrec_helper(akku.prepend(self.first))
    end
  end
  
  p List[1,2,3].reverse_endrec
  
  #Merges two lists
  #
  #+ ::= (self,list) :: List x List => List
  #
  #Test {
  #(List[1,2],List[3,4]) => List[1,2,3,4], (List[],List[]) => List[],
  #(List[1,2],'a') => Err
  #
  def + list
    check_pre(list.list?)
    if self.rest.empty? then list.prepend(self.first)
    else (self.rest + list).prepend(self.first)
    end
  end
end


class Array

  def array?; true end

  #Checks whether an Array has a given Element
  #
  #elem? ::= (self,elem) :: Array x Any => Bool
  #
  #Test{
  #(Array[1,2,3],2) => True, (Array[],2) => false}
  #
  def elem? elem
    if    self == []      then false
    elsif self[0] == elem then true
    else  self.drop(1).elem?(elem)
    end
  end

  #Determines the reverse of an Array
  #
  #reverse_endrec ::= (self) :: Array => Array
  #
  #Test {
  #Array[1,2,3] => Array[3,2,1], Array[] => Array[]}
  #
  def reverse_endrec
    self.reverse_endrec_helper([])
  end

  def reverse_endrec_helper akku
    if    self == [] then akku.flatten
    else (self.drop(1)).reverse_endrec_helper([self[0],akku])
    end
  end

  #Merges two Arrays
  #
  #+ ::= (self,array) :: Array x Array => Array
  #
  #Test{
  #(Array[1,2],Array[3,4]) => Array[1,2,3,4], (Array[],Array[]) => Array[]
  #(Array[1,2],'a') => Err
  #
  def + array
    check_pre(array.array?)
    if    array == [] then self
    else (self << array[0]) + array.drop(1)
    end
  end

  #Transforms an Array to an Integer
  #
  #to_int_ ::= (self) :: Array => Int
  #
  #Test {
  #Array[1,2,3] => 123, Array[] => 0}
  #
  def to_int_
    if    self == [] then 0
    else  self.to_int_helper(0)
    end
  end

  def to_int_helper akku
    if    self.length == 1 then akku + self[0]
    else  akku = akku + self[0] * 10 ** (self.length - 1)
      (self.drop(1)).to_int_helper(akku)
    end
  end

  def even_only
    if    self == []      then []
    elsif self[0]%2 == 0  then [self[0]] + self.drop(1).even_only
    else  self.drop(1).even_only
    end
  end

  def flatten
    if    self == []      then []
    elsif self[0].array?  then self[0].flatten + self.drop(1).flatten
    else  [self[0]] + self.drop(1).flatten
    end
  end

  def no_of_leaves_
    if    self == []      then 0
    elsif self[0].array?  then self[0].no_of_leaves_ + self.drop(1).no_of_leaves_
    else  1 + self.drop(1).no_of_leaves_
    end
  end

  def pairs_do_ &block
    if self == [] then []
    else [(yield self[0])] + self.drop(1).pairs_do_(&block)
    end
  end
end


class Set
  
  def set?; true end
  
  def superset_?(set)
    check_pre(set.set?)
    if    set == []           then true
    elsif self.elem?(set[0])  then self.superset_?(set.drop(1))
    else  false
    end
  end

  def elem?(elem)
    self.any?{|a| a == elem}
  end
  
  def == aSet
    check_pre(aSet.set?)
    self.all? {|a| aSet.elem?(a)} && aSet.all? {|a| self.elem?(a)}
  end
end


class Hash
  def equals_ aHash
    if not aHash.hash? then false
    else self.keys.all? {|a| self[a] == aHash[a]} and aHash.keys.all? {|a| self[a] == aHash[a]}
    end
  end

  def add_counts_ a_hash
    if self.empty?                                    then a_hash
    elsif a_hash.keys.none?{|a| self.keys.elem?(a)}   then a_hash.merge(self)
    elsif a_hash.keys.elem?(self.keys[0])             then
      a_hash[self.keys[0]] = a_hash[self.keys[0]] + self[self.keys[0]]
      self.drop(1).add_counts_ a_hash   #ich kann keine Elemente aus einem Hash droppen - warum auch immer...
    else
      self.drop(1).add_counts_ a_hash
    end
  end
end

module Enumerable
  def to_arr
    akku = []; self.each {|a| akku << a}; return akku
  end
  
  def map_
  akku = []; self.each {|a| akku << (yield a)}; return akku
  end
  
  def any_?
    (self.map_ {|a| yield a}).reduce {|a,b| a || b}
  end
  
  def max_
    
  end
  
  def freq_count_
    hash = Hash.new
    self.each{|a| 
      if hash.has_key?(a) then hash[a] = hash[a] + 1 
      else hash[a] = 1
      end
    }
    hash
  end
end
