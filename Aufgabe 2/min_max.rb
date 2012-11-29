#Minimum of two numbers.
#
#min_int ::= (x,y) ::
#Int x Int -> Int 
#Test {(2,3) => 2, (2,2) => 2,(0,0) => 0, (4,2) => 2, 
#     ('3',5) => Err,(3,'5') => Err, (2.3,4) => Err}


require_relative '../Extensions/ext_pr1_v4.rb'

def min_int(x,y)
  
  check_pre(x.int? && y.int?)     #The Test if the arguments are Integer
  
  return ((x < y)? x : y)         #Konditionaloperater if x smaller than y then return x else return y
 
end


#Maximum of two numbers.
#
#max_int ::= (x,y) ::
#Int x Int -> Int
#Test {(2,3) => 3, (2,2) => 2,(0,0) => 0, (4,2) => 4,
#('3',5) => Err,(3,'5') => Err, (2.3,4) => Err}


def max_int (x,y)

  check_pre(x.int? && y.int?)     #The Test if the arguments are Integer

  return ((x > y)? x : y)         #Konditionaloperater if x bigger than y then return x else return y

end