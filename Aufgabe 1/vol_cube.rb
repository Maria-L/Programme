# Purpose
# Calculate the volume of an n-dimensional cube

# Contract
# vol_cube ::= (length_outer_cube, length_inner_cube, number_of_dimensions) :: Nat X Nat X Nat ->? Nat :::: length_outer>=length_inner :::: number_of_dimensions > 0

# TEST{
#(2, 2, 2) => 0, (4, 2, 2) => 12,
#(4, 2, 2) => ERR, (2, 4, 2) => ERR, (4, 2, 0) => ERR, (-4, 2, 2) => ERR, (4, -2, 2) => ERR, (4, 2, -2) => ERR }

# Exceptions
# n < 1
# x <= y
# {x, y} < 0
# n not natural number

require_relative '../Extensions/ext_pr1_v4.rb'


def cube(x, n)
  return x**n
end

def vol_cube x, y, n
  
  check_pre(n.nat? && 
      x.nat? && 
      y.nat? && 
      n != 0 && 
      x >= y)

  return cube(x, n) - cube(y, n)      # return cube1 - cube2
end
