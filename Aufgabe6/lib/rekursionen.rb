$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','Extensions')

require'test/unit'
require_relative '../Extensions/ext_pr1_v4'

##### Einfachrekursion #####

#Calculate the sum of a natural number n from 0 to n
#
#sum ::= (n) :: Nat -> Nat
#
#Test{ (1) => 1, (0) => 0,(18) => 171,
#      ("a") => Err, (-2) => Err}
def sum(n)
  check_pre(n.nat?)
  ((n <= 0)? n:  n + sum(n-1))
end

#Calculate the power n above a natural number x
#
#pot ::= (x,n) :: Nat x Nat -> Nat
#
#Test{ (5,0)=> 1, (5,1) => 1, (5,2) => 25,
#      (-5,0) => Err,(0,-5) => Err, ("a",3) => Err, (3,"a") => Err}
#
def pot(x,n)
  check_pre(x.nat? && n.nat?)
  if n == 0 then 1
  else n <= 0? x : x*pot(x,n-1)
  end
end

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


def sum_(n)
  check_pre(n.int? && n >= 0)
  sum_helper(0,n)
end

def sum_helper(accu,n)
  if n == 0 then accu
  elsif n > 0   then sum_helper(accu+n,n-1)
  else check_pre(false)
  end
end

#
def pot_ (x, n)
  check_pre(n.int? && n >= 0 && x.int?)
  pot_helper(x,n,1)
end

def pot_helper(x, n, akku)
  if    n == 0  then akku
  elsif n > 0   then pot_helper(x, n-1,akku * x)
  else check_pre(false)
  end
end


def fibo_ n
  fibo_helper n, 0, 0
end

def fibo_helper n, akku1, akku2
  if    n == 0  then akku1 + akku2
  elsif n == 1  then akku1 + akku2 + 1
  elsif n > 1   then fibo_helper()
  else check_pre(false)
  end
end

##### Iteration mit While #####

def sum_it(n)
  check_pre(n.int? && n >= 0)
  akku = 0
  while n > 0
    akku = akku + n
    n = n - 1
  end
  akku
end

def pot_it(x, n)
  check_pre(n.int? && n >= 0 && x.int?)
  akku = 1
  while n > 1
    akku = akku * x
    n = n - 1
  end
  akku
end


##### Iteration mit reduce #####

def sum_red n
  check_pre(n.int? && n >= 0)
  (1..n).reduce(){|a,b| a + b}
end

def pot_red x, n
  check_pre(n.int? && n >= 0 && x.int?)
  (1..n).reduce() {|a,b| x * x}
end


  
