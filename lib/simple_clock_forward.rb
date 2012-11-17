#Purpose
#Forward a set time

#Contract
#simple_clock_forward ::= (hour, minute, second) :: Nat X Nat X Nat ->? [Nat, Nat, Nat] :::: hour >= 0 :::: minute >= 0 :::: second >= 0

#TEST {
#(13, 14, 15) => [13, 14, 15], (1, 14, 15) => [1, 14, 15],
#(26, 10, 12) => [2, 10, 12], (0, 0, 0) => [0, 0, 0],
#(-1, 2, 3) => ERR, (1, -2, 3) => ERR, (1, 2, -3) => ERR, 
#(1.1, 2, 3) => ERR, (1, 2.1, 3) => ERR, (1, 2, 3.1) => ERR


require_relative '../Extensions/ext_pr1_v4.rb'


$min_to_sec = 60
$hour_to_min = 60
$day_to_hour = 24

$hour_to_sec = $min_to_sec * $hour_to_min
$day_to_min = $day_to_hour * $hour_to_min
$day_to_sec = $hour_to_sec * $day_to_hour

$stunde = 0
$minute = 0
$sekunde = 0


def simple_clock_forward stunde, minute, sekunde

  ########### Exceptioncheck ##########

  check_pre(
    (stunde.nat?) && 
      (minute.nat?) && 
      (sekunde.nat?)
  )

  ########## Function ##########
                                                #Add up the whole time in seconds
  t_ges = stunde * $hour_to_sec + minute * $min_to_sec + sekunde + $stunde * $hour_to_sec + $minute * $min_to_sec + $sekunde
 
  s_n = t_ges % $min_to_sec                     #Calculate seconds

  t_ges_os = (t_ges - s_n) / $min_to_sec        #Calculate missing time in minutes
  m_n = t_ges_os % $min_to_sec                  #Calculate minutes

  t_ges_om = (t_ges_os - m_n) / $hour_to_min    #Calculate missing time in hours
  h_n = t_ges_om % $day_to_hour                 #Calculate hours
  
  
  return [h_n, m_n, s_n]                        #return
end
