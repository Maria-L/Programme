require_relative'../Extensions/ext_pr1_v4'


class Integer
  def raise_to n
    check_pre(n.int? && n >= 0)
    if n == 0 then 1
    elsif n == 2 then self * self
    elsif n % 2 == 0 then (self.raise_to(n/2)).raise_to(2)
    else self * self.raise_to(n-1)
    end
  end
end

class Array
  def tree_depth
    check_pre(self.integer_array?)
    self_c = self
    self_c.map{|a| if a.array? then 1 + a.tree_depth else 1 end}.reduce {|a,b| if a > b then a else b end}
  end
  
  def integer_array?
    all? {|a| 
      if a.array? then a.integer_array? 
      elsif a.int? then true
      else return false
      end
    }
  end
  
  def my_collect &block
    check_pre(block_given?)
    akku = Array.new
    self.each {|a| akku << (yield a)}; akku
  end
end

class Hash
  def merge_ hash
    check_pre(hash.hash?)
    self.each {|key,elem| if not hash.has_key?(key) then hash[key] = elem end}; hash
  end
end
