#Purpose
#Forward a set time and be able to switch between 12h and 24h display by
#adding 0 for 12h and 1 for 24h as last Argument

#Contract
#clock_forward ::= (hour, minute, second, hour_a, minute_a, sekunde_a, am_pm) :: Int X Int X Int X Int X Int X Int X  Nat->? [Nat, Nat, Nat, String] :::: am_pm == 0 || am_pm == 1

#TEST {
#(13, 14, 15, 0, 0, 0, 1) => [13, 14, 15, ""], (13, 14, 15, 0, 0, 0, 0) => [1, 14, 15, "pm"], (1, 14, 15, 0, 0, 0, 0) => [1, 14, 15, "am"],
#(26, 10, 12, 0, 0, 0, 0) => [2, 10, 12, 0, 0, 0, "am"], (0, 0, 0, 0, 0, 0, 0) => [0, 0, 0,"am"],
#(1.1, 2, 3, 0, 0, 0, 1) => ERR, (1, 2.1, 3, 0, 0, 0, 1) => ERR, (1, 2, 3.1, 0, 0, 0, 1) => ERR
#(1, 2, 3, 0, 0, 0, 5) => ERR, (1, 2, 3, 0, 0, 0, 1.0 => ERR}


require_relative '../Extensions/ext_pr1_v4.rb'


$min_to_sec = 60
$hour_to_min = 60
$day_to_hour = 24

$hour_to_sec = $min_to_sec * $hour_to_min
$day_to_min = $day_to_hour * $hour_to_min
$day_to_sec = $hour_to_sec * $day_to_hour


def time_to_sec stunde, minute, sekunde
  
  check_pre(stunde.int? &&
      minute.int? &&
      sekunde.int?)
  
  return stunde * $hour_to_sec + minute * $min_to_sec + sekunde
end


def clock_forward stunde, minute, sekunde, stunde_a, minute_a, sekunde_a, am_pm

  ########### Exceptioncheck ##########

  check_pre(
    (stunde.int?) && 
      (minute.int?) && 
      (sekunde.int?) && 
      (stunde_a.int?) &&
      (minute_a.int?) &&
      (sekunde_a.int?) &&
      (am_pm.int?) &&
      (am_pm == 1 || am_pm == 0)
  )

  ########## Function ##########
  #Add up the whole time in seconds
  t_ges = time_to_sec(stunde, minute, sekunde) + time_to_sec(stunde_a, minute_a, sekunde_a)
 
  s_n = t_ges % $min_to_sec                     #Calculate seconds

  t_ges_os = (t_ges - s_n) / $min_to_sec        #Calculate missing time in minutes
  m_n = t_ges_os % $hour_to_min                 #Calculate minutes

  t_ges_om = (t_ges_os - m_n) / $hour_to_min    #Calculate missing time in hours
  h_n = t_ges_om % $day_to_hour                 #Calculate hours

  
  if h_n < 13 && am_pm == 0                     #deal with am and pm
    add = "am"
  elsif h_n > 12 && am_pm == 0
    add = "pm"
    return [h_n - 12, m_n, s_n, add]
  else
    add = ""
  end
  
  
  return [h_n, m_n, s_n, add]                   #return
end


#clock_suc(hour, min, sec) ::= Int X Int X Int => [Int, Int, Int, String]
#TEST {(15, 12, 30) => (15, 12, 31,""), (23, 59, 59) => (0, 0, 0, ""), 
#       ('15', 12, 30) => Err, (15, '12', 30) => Err, (15, 12, '30') => Err}
#

def clock_suc hour, min, sec                    #Clock Successor
  
  check_pre((hour.int?) &&
      (min.int?) &&
      (sec.int?))
  
  clock_forward(0, 0, 1, hour, min, sec, 1)
end


#clock_pre(hour, min, sec) ::= Int X Int X Int => [Int, Int, Int, String]
#TEST {(15, 12, 30) => (15, 12, 29,""), (0, 0, 0) => (23, 59, 59, ""), 
#       ('15', 12, 30) => Err, (15, '12', 30) => Err, (15, 12, '30') => Err}
#


def clock_pre hour, min, sec                    #Clock Predecessor
  
  check_pre((hour.int?) &&
      (min.int?) &&
      (sec.int?))
  
  clock_forward(0, 0, -1, hour, min, sec, 1)
end