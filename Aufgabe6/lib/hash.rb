$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','Extensions')

#require'test/unit'
require_relative '../Extensions/ext_pr1_v4'

#Proove if self is equal to aHash
#
#equals_ ::= (aHash) :: Hash -> Bool
#
#Test{ (Hash["a" =>1],Hash["a" =>1]) => true, (Hash["a" =>1,"b" =>2],Hash["a" =>1])=> false, 
#       (Hash["a" =>1],Hash["a" =>2])=> false, (Hash["a" =>1,"b" =>2],Array[1,2])=> false}

class Hash
  def equals_ aHash
    if not aHash.hash? then false
    else self.keys.all? {|a| self[a] == aHash[a]} and aHash.keys.all? {|a| self[a] == aHash[a]}
    end
  end

#Add the Values of the keys of both hashes
#
#add_counts_::= (a_hash) :: Hash -> Hash
#
#Test{ (Hash["a" =>1],Hash["a" =>1]) => Hash["a" => 2], (Hash["a" =>1, "b" => 2],Hash["a" =>1]) => Hash["a" => 2, "b" => 2],
#      (Hash["a" =>1, "b" => 2], Hash["c" => 3]) => Hash["a" => 1, "b" => 2, "c" => 3]
#      (Hash["a" =>1],"a") => Err}

  
  def add_counts_ a_hash
    check_pre(a_hash.hash?)
    self.each_key {|a| 
      if a_hash.include?(a) then a_hash[a] = a_hash[a] + self[a]
      else a_hash[a] = self[a]
      end
    }
    a_hash
  end
end
