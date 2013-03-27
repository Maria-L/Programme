
class Integer
  def raise_to n
    if n == 0         then 1
    elsif n == 2      then self * self
    elsif n % 2 == 0  then (self.raise_to(n/2)).raise_to(2)
    else self * self.raise_to(n-1)
    end
  end
end

class Array
  def integer_array?
    self.all?{|a| if a.is_a?(Array) then a.integer_array? else a.is_a?(Integer) end}
  end
  
  def tree_depth
    if not self.integer_array? then "Err" end
    self.map {|a| if a.is_a?(Integer) then 1 
      else 1 + a.tree_depth
      end}.reduce {|a,b| if a > b then a else b end}
  end
  
  def my_collect &block
    akku = Array.new
    self.each {|a| akku << (yield a)}; akku
  end
  
  def merge hash
    self.each {|key,value| hash[key] = value}; hash
  end
end
