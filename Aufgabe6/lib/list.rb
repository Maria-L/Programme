$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','Extensions')

#require'test/unit'
require_relative '../../Extensions/ext_pr1_v4'

class List
  def reverse_endrec()
    if !(self.empty?)
    self.reverse_endrec_h(List[self.first],self.rest)
    else List[]
    end
  end

  def reverse_endrec_h(l,rest1)
    if rest1.empty? then l
    else reverse_endrec_h(l.prepend(rest1.first),rest1.rest)
    end
  end


  def +(n)

    if self.rest.empty? then n.prepend(self.first)
    else ((self.rest)+n).prepend(self.first)
    end
    
   end
  end

#pairlist = List[1,2,3]
puts pairlist.reverse_endrec
puts List[1,2,3,4,5,6]+List[4,5,6]

