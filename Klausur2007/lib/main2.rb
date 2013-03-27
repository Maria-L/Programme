

#Gibt ein neues Array zurück, was nur noch die Elemente des Receivers enthält,die nicht in other_arr vorkommen.
#
#all_without ::= (other_arr) :: Array x Array => Array
#
#Test {(Array[1,2,3,4],Array[1,2,3]) => Array[4], (Array[],Array[1,2,3]) => Array[],
#(Array[1,2,3,4],Array[]) => Array[1,2,3,4],
#(Array[1,2,3,4],'a') => Err }
#
#
class Array
  def all_without other_arr
    akku = Array.new
    self.each {|a| if not other_arr.include?(a) then akku << a end}
    akku
  end
  
  #Konvertiert Array zu Integerintervall, sofern das möglich ist
  #
  #to_int_range ::= Array ->? Intervall :::: Array.all?(|a| a.Integer?), Array.drop(1).all?(|a| a - 1 == self[i-1])
  #
  #Test {Array[1,2,3,4,5] -> (1..5),
  #     Array[1,2,4] -> Err, Array[] -> Err}
    
  def to_int_range
    i = 0
    if self == [] then return "Err" end
    while i < self.size - 1
      if self[i] != self[i+1] - 1 then return "Err" end
      i = i + 1
    end
    (self[0]..self[-1])
  end
    
  #Wandelt geeignete Arrays in Hashes um.
  #
  #to_hash ::= Array ->? Hash :::: Array.all? {|a| a.sice == 2}
  #
  #Test{ Array[[1,2],[3,4]] -> Hash{1 => 2,3 => 4}, Array[] -> Hash{},
  #Array[[1,2,3]] -> Err}
  #
    
  def to_hash
    #if not self.all? {|a| a.length == 2 && a.is_a?(Array)} then "Err" end
    akku = Hash.new
    self.each {|a,b| akku[a] = b}
    akku
  end
  #Dreht das Array und jedes Element, was auch ein Array ist,um
  #
  #reverse_rec ::= Array -> Array
  #
  #Test {[1,2,3,[4,5,6]] -> [[6,5,4],3,2,1], [] -> []
  #
  
  def reverse_rec
    self.reduce(Array.new) {|a,b|
      if b.is_a?(Array) then [b.reverse_rec].concat(a)
      else [b].concat(a)
      end
    }
  end
end  
