$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','Extensions')

#require'test/unit'
require_relative '../../Extensions/ext_pr1_v4'
require 'set'

class Set
  def superset?(n)
    check_pre(self.size >= n.size)
    n.all?{|elem| self.include?(elem)}
  end

  def ==(n)
    self.size == n.size and self.superset?(n)
  end
end

puts Set[1, 2, 3, 4].superset?(Set[])
puts Set[1,2,3,4]==Set[4,2,3,1]