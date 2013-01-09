$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','Extensions')

#require'test/unit'
require_relative '../Extensions/ext_pr1_v4'

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
  
  #Merges two lists
  #
  #+ ::= (self,list) :: List x List => List
  #
  #Test {
  #(List[1,2],List[3,4]) => List[1,2,3,4], (List[],List[]) => List[],
  #(List[1,2],'a') => Err
  #
  def +(n)
    if self.rest.empty? then n.prepend(self.first)
    else ((self.rest)+n).prepend(self.first)
    end
  end
end
