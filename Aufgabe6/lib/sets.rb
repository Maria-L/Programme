$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','Extensions')

#require'test/unit'
require_relative '../Extensions/ext_pr1_v4'
require 'set'

class Object
  def array?; false end
  def set?; false end
end

class Set
  
#Proove if self is a superset of n
#
#superset?::=(n):: Set -> Bool
#
#Test{ (Set[1,2,3,4],Set[1,2,3]) => true, (Set[1,2,3],Set[1,2,3]) => true,
#      (Set[1,2,3,4],Set[4,5,6]) => false,(Set[1,2],Set[1,2,3]) => false,
#       (Set[1,2,3,4],"a") => Err}  
  def superset?(n)
    check_pre(n.set?)
    n.all?{|elem| self.include?(elem)}
  end
  
#Proove if self is equal with n
#
#== ::= (n):: Any -> Bool
#
#Test{(Set[1,2,3,4],Set[1,2,3,4]) => true,(Set[2,1,3,4],Set[1,2,3,4]) => true,
#     (Set[8,7,6,5],Set[1,2,3,4]) => false,(Set[1,2],Set[1,2,3,4]) => false}

  def ==(n)
    n.set? and self.size == n.size and self.superset?(n)
  end
end
