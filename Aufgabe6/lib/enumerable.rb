require_relative '../Extensions/ext_pr1_v4'
require 'set'

###Frage: Wie stelle ich sicher, dass Enumerable auch für List und Set definiert ist? 
###       Bzw sollte es das eigentlich sein?


module Enumerable
  
  #Turns any Enumerable into an Array
  #
  #to_arr ::= (self) :: Enumerable => Array
  #
  #Test {Hash[1,2,3,4] => Array[[1,2],[3,4]], List[] => Array[]}
  #
  def to_arr
    akku = []; self.each {|a| akku << a}; return akku
  end
  
  
  #Maps any Method with one argument over any Enumerable
  #
  #map_ ::= (self) :: Enumerable => Enumerable
  #
  #Test{Array[1,2,3,4] {|a| a + 1} => Array[2,3,4,5], List[] {|a| a + 1} => List[],
  #Array[] => Err
  #
  def map_
    check_pre(block_given?)
    akku = []; self.each {|a| akku << (yield a)}; return akku
  end
  
  #Checks if a Predicat is true for at least one Element of an Enumerable
  #
  #any_? ::= (self) :: Enumerable => Bool
  #
  #Test {Array[1,2,3,4] {|a| a < 5} => true, Array[1,2,3,4] {|a| a < 1} => false,
  #Array[] {|a| a < 5} => false, Array[1,2,3,4] => Err}
  #
  def any_?
    check_pre(block_given?)
    (self.map_ {|a| yield a}).reduce(false) {|a,b| a || b}
  end
 
  
  #?!?
  
  def max_
    
  end
  
  
  #Counts the frequency of Elements, where the keys are the Elements countet and the elements the Number of counts
  #
  #freq_count_ ::= (self) :: Enumerable => Hash
  #
  #Test{Array[1,2,2,3] => Hash[1 => 1,2 => 2,3 => 1], List[] => Hash{}}
  #
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
