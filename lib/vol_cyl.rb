# Purpose
# Calculate the volume of a cylinder

# Contract
# vol_cyl ::= (radian, height) :: Float X Float ->? Float :::: radian >= 0 :::: height >= 0

# TEST {
# (2.0, 2.0) => 0, (5.0, 4.0) => 141.37,
# (-5.0, 4.0) => ERR, (5.0, -4.0) => ERR, (5, 4.0) => ERR, (5.0, 4) => ERR }

# Exceptions
# radian < 0
# height < 0

require_relative '../Extensions/ext_pr1_v4.rb'


def vol_cyl(height, radian)
  ########### Exceptioncheck ##########
  check_pre(
    (radian.float?) &&
      (height.float?) &&
      (radian >= 0) &&
      (height >= 0)
  )

  
  ########### Function ##########
  volume = height * radian ** 2 * Math::PI

  return volume
end
