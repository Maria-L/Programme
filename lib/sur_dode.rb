# Purpose
# Calculate the volume of a dodekaeder

# Contract
# sur_dode ::= (n) :: Float ->? Float :::: n >= 0

# TEST {
# (4.0) => 330.3316609, (0.0) => 0.0, 
# (-4.0) => ERR, (4) => ERR }


require_relative '../Extensions/ext_pr1_v4.rb'

CONST = Math::sqrt(25 + 10 * (Math::sqrt(5)))

def sur_dode n

  check_pre((n >= 0) && 
      (n.float? &&
      n >= 0.0)
  )
  
  sur = 3 * n ** 2 * CONST
  
  return sur
end
