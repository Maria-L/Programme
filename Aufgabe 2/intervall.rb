#Test if a number is between two other numbers
#
#within? ::= (val, lower, upper)::
#Int x Int x Int ->? Bool ::::
#(lower <= upper) ::
#Test{(3, 1, 8) => true,(3, -1, 8) => true, (3, 3, 5) => true,
#     (5,3,5) => true,(3,3,3) => true, (3,4,7) => false,
#     ('3',3,5) => Err,(3,'3',5) => Err,(3,3,'5') => Err, (2.1,1,5) => Err,
#     (2,1.8,5) => Err,(2,1,5.6) => Err, (3,3,1) => Err}
#

require_relative '../Extensions/ext_pr1_v4.rb'

def within? (val, lower, upper)
  
  check_pre (val.int? &&
      lower.int? &&
      upper.int? &&
      lower <= upper)

  (val >= lower) and (val <= upper)
  
end
