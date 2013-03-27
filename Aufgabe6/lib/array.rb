$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','Extensions')

#require'test/unit'
require_relative '../Extensions/ext_pr1_v4'

class Object
  def array?; false end
  def set?; false end
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

  #Gives only the even numbers of an array
  #
  #even_only ::= (self) :: Array => Array :::: self.all? {|a| a.int?}
  #
  #Test {Array[].even_only => Array[], Array.even_only[1,2,3,4] => Array[2,4]
  #Array['a','b'] => Err}
  #
  def even_only
    check_pre(self.all? {|a| a.int?})
    if    self == []      then []
    elsif self[0]%2 == 0  then [self[0]] + self.drop(1).even_only
    else  self.drop(1).even_only
    end
  end
  
  
  #Flattens an Array with Any elements
  #
  #flatten ::= (self) :: Array => Array
  #
  #Test {Array[] => Array[], Array[Array[Array[],3,4],Array[1,2,3,4]] => Array[3,4,1,2,3,4]}
  #
  def flatten
    if    self == []      then []
    elsif self[0].array?  then self[0].flatten + self.drop(1).flatten
    else  [self[0]] + self.drop(1).flatten
    end
  end
  
  
  #Counts the number of Elements in an unflattened Array
  #
  #no_of_leaves ::= (self) :: Array => Int
  #
  #Test{ Array[] => 0,ArrayArray[Array[Array[],3,4],Array[1,2,3,4]] => 6}
  #
  def no_of_leaves_
    if    self == []      then 0
    elsif self[0].array?  then self[0].no_of_leaves_ + self.drop(1).no_of_leaves_
    else  1 + self.drop(1).no_of_leaves_
    end
  end

  
  #Maps a function over an Array of Arrays with two elements
  #
  #pairs_do ::= (self) :: Array => Array :::: self.all? {|a| a.length == 2}
  #
  #Test {Array[[1,2],[3,4]] {|a,b| a + b} => Array[3,7], Array[] {|a,b| a + b} => Array[]
  #Array[[1,2],[3,4]] => Err}
  #
  def pairs_do_ &block
    check_pre(self.all? {|a| a.length == 2} && block_given?)
    if self == [] then []
    else [(yield self[0])] + self.drop(1).pairs_do_(&block)
    end
  end
end

p [[1,2],[3,4]].pairs_do_ {|a,b| a + b}