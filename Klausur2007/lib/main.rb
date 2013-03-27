class Object
  def array?; false end
end

class Array
  def array?; true end
  
  def all_without array
    #check_pre(array.array?)
    akku = []
    self.each {|a| if not array.include?(a) then akku << a end}
    akku
  end
  
  def all_without_m(array);reject{|a| array.include?(a)}end
  #(self.map{|a| if !(array.include?(a)) then a end})
   
  def to_int_range
    i = 0
    while i < self.length - 1
      if not self[i] + 1 == self[i+1] then return "FFUUU" end
      i = i + 1
    end
    (self[0]..self[self.length - 1])
  end
  
  def to_hash
    #chech_pre(self.all {|a| a.length == 2 && a.array?})
    akku = Hash.new
    self.each {|a| akku[a[0]] = a[1]}
    akku
  end
  
  def reverse_rec
    akku = Array.new
    self.each {|a| 
      if a.array? then akku = [a.reverse_rec].concat(akku)
      else akku = [a].concat(akku)
      end
    }
    akku
  end
end
