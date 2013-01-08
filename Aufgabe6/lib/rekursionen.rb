$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','Extensions')

require'test/unit'
require_relative '../../Extensions/ext_pr1_v4'

##### Einfachrekursion #####

#Calculate the sum of a natural number n from 0 to n
#
#sum ::= (n) :: Nat -> Nat
#
#Test{ (1) => 1, (0) => 0,(18) => 171,
#      ("a") => Err, (-2) => Err}
#def sum(n)
#  check_pre(n.nat?)
#  ((n <= 0)? n:  n + sum(n-1))
#end

#p sum(18)

#Calculate the power n above a natural number x
#
#pot ::= (x,n) :: Nat x Nat -> Nat
#
#Test{ (5,0)=> 1, (5,1) => 1, (5,2) => 25,
#      (-5,0) => Err,(0,-5) => Err, ("a",3) => Err, (3,"a") => Err}
#
#def pot(x,n)
#  check_pre(x.nat? && n.nat?)
#  if n == 0 then 1
#  else n <= 0? x : x*pot(x,n-1)
#  end
#end

#p pot(5,2)

#Calculate the Fibunacci Number n
#
#fibo ::= (n) Nat => Nat
#
#Test{ (0) => 0,(1) => 1, (6) => 8,
#      ("a") => Err, (-2) => Err}
def fibo(n)
  check_pre(n.nat?)
  if n == 0 then 0 else (n == 1? 1: fibo(n-1)+fibo(n-2)) end
end

#p fibo(6)

##### Endrekursion #####
#def sum_e(n)
#  sum_(n,0)
#end
#
#def sum_(n,sum)
#  if n == 0 then sum
#  else sum_(n-1,sum+n)
#  end
#end
#
##p sum_e(5)
#
def pot_e(x,n)
  pot_(x,n,1)
end

def pot_(x,n,pot)
  if n == 0 then pot
  elsif n== 1 then pot
  else pot_(x,n-1,x*pot)
  end
end

#p pot_e(2,4)
#
#
#def fibo(n)
#  fibo_(n,1,0)
#end
#
#def fibo_(n,accu,acu)
#  if n == 0 then acu
#  elsif n == 1 then accu
#  else
#  end
#end
##### Iteration mit While #####

#def sum_w(n)
#  int sum
#  while n > 0
#    sum = sum + n
#    n - 1
#  end
#  sum
#end
#
def pot_w(x,n)
  pot = 1
  while n <= 0
    pot = pot+x*x
    n=n-1
  end
  pot
end
#
#def fibo_w(n)
#
#end
p pot_w(1,2)
##### Iteration mit reduce #####

def sum_r(n)
  (0..n).reduce(:+)
end

def pot_r(x,n)
  (n <= 0)? 1:(n == 1)? x:(1..n).reduce{x*x}
end

#p pot_r(5,1)

def fibo_r(n)
  
end