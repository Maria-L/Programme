require_relative'../Extensions/ext_pr1_v4'


def fibo n
  check_pre(n.int? && n >= 0)
  if n == 0 then 0
  elsif n == 1 then 1
  else fibo(n-1) + fibo(n-2)
  end
end


class Array
  def size_
    if self.empty? then 0
    elsif not self[0].array? then 1 + self.drop(1).size_
    else self[0].size_ + self.drop(1).size_
    end
  end
  
  def deep_reverse_
    self.reduce(Array.new) {|akku,elem| if elem.array? then [elem.deep_reverse_].concat(akku) else [elem].concat(akku) end}
  end
  
  def leaf_count
    if self.empty? then 0
    elsif self[0].array? then self[0].leaf_count + self.drop(1).leaf_count
    else 1 + self.drop(1).leaf_count
    end
  end
  
  def each_second &block
    i = 0
    while i < self.length
      yield self[i]
      i = i + 2
    end
  end
end

[1,2,3,4,5,6].each_second {|elem| puts elem}

class String
  def switch_case
    akku = ""
    self.each_char {|a| 
      if ("a".."z").include?(a) then akku = akku + a.upcase 
      elsif ("A".."Z").include?(a) then akku = akku + a.downcase
      else akku = akku + a.downcase
      end
    }
    akku
  end
end

class List
  def count_elems_in_list
    count_elems_in_list_helper(Hash.new)
  end
  
  def count_elems_in_list_helper akku
    if self.empty? then akku
    elsif self.first.list?          then (self.first.count_elems_in_list).add_counts(self.rest.count_elems_in_list)
    elsif akku.has_key?(self.first) then akku[self.first] = akku[self.first] + 1
      self.rest.count_elems_in_list_helper(akku)
    else akku[self.first] = 1
      self.rest.count_elems_in_list_helper(akku)
    end
  end
end

class Hash
  def add_counts hash
    self.each {|key,value| 
      if hash.has_key?(key) then hash[key] = hash[key] + self[key]
      else hash[key] = value
      end
    }
    hash
  end
end

p List[List[1,2,3],List[1,2]].count_elems_in_list