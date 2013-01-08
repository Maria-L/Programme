$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','Extensions')

#require'test/unit'
require_relative '../../Extensions/ext_pr1_v4'

class Array
  def to_int
    check_pre(all?{|elem| elem.int?})
    #self.each{|elem|l = l+elem.to_s}

  end
  
  def even_only
    
  end
  
  def flatten
    
  end
  
  def no_of_leaves
    
  end
  
  def pairs_do
    
  end

end

puts Array[1,2,3].to_int