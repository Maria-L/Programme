$LOAD_PATH.unshift File.join(File.dirname(__FILE__),'../..','Extensions')

$MIN_IN_SEC = 60
$HOUR_IN_MIN = 60
$DAY_IN_HOUR = 24

$HOUR_IN_SEC = $HOUR_IN_MIN * $MIN_IN_SEC
$DAY_IN_SEC = $DAY_IN_HOUR * $HOUR_IN_SEC

require_relative'../Extensions/ext_pr1_v4'
require_relative'../Extensions/ext_classes_v1'
require_relative'object'
require_relative'clock_sec'
require_relative'clock24'
require_relative'clock12'
require_relative'praedicats'


#Test{
#     (Clock24[12,34,2],Clock12[:AM, 9,6,8]) => Clock24[21,40,10],
#     (Clock24[12,34,2],ClockSec[3600]) => Clock24[13,34,2],
#     (Clock24[5,45,22],Clock24[3,5,22]) => Clock24[8,50,44]
#     (Clock12[:PM,2,34,2],ClockSec[3600]) => Clock12[:PM,3,34,2],
#     (Clock12[:AM,9,34,2],Clock24[1,6,8]) => Clock12[:AM,10,40,10],
#     (Clock12[:AM,8,0,23],Clock12[:AM,2,0,0]) => Clock12[:AM, 10,0,23]
#     (ClockSec[3600],Clock12[:AM,9,15,22]) => ClockSec[36922]
#     (ClockSec[3600],Clock24[6,23,45]) => ClockSec[26625]
#     (ClockSec[3600],ClockSec[400]) => ClockSec[4000] 
#     (100, Clock12[:AM,1,2,3]) => Err, (Clock24[1,2,3], 100) => Err}
#

#def clock_add (clock1,clock2)
#  check_pre(clock?(clock1) && clock?(clock2))
#  
#  to_clock(clock_sec_add(to_clock_sec(clock1), to_clock_sec(clock2)), clock1)
#end
#
##Subtracts two random clocks
##
##clock_sub ::== (clock1, clock2) ::
##Clock x Clock -> Clock ::
##   (Clock24 x Clock -> Clock24 |
##    Clock12 x Clock -> Clock12 |
##    ClockSec x Clock -> ClockSec)
##
##Test{
##     (Clock24[0,1,40],Clock12[:AM,0,1,40]) => Clock24[0,0,0],
##     (Clock24[0,1,40],ClockSec[100]) => Clock24[0,0,0],
##     (Clock24[0,1,40],Clock24[0,1,40]) => Clock24[0,0,0]
##     (Clock12[:AM,0,1,40],ClockSec[100]) => Clock12[:AM,0,0,0],
##     (Clock12[:AM,0,1,40],Clock24[0,1,40]) => Clock12[:AM,0,0,0],
##     (Clock12[:AM,0,1,40],Clock12[:AM,0,1,40]) => Clock12[:AM,0,0,0],
##     (ClockSec[100],Clock12[:AM,0,1,40]) => ClockSec[0],
##     (ClockSec[100],Clock24[0,1,40]) => ClockSec[0],
##     (ClockSec[100],ClockSec[100]) => ClockSec[0],
##     (100, Clock12[:AM,1,2,3]) => Err, (Clock24[1,2,3], 100) => Err}
#
#def clock_sub (clock1, clock2)
#  check_pre(clock?(clock1) && clock?(clock2))
#  
#  to_clock(clock_sec_sub(to_clock_sec(clock1), to_clock_sec(clock2)), clock1)
#end
#
#
#def clock_equal (clock1, clock2)
#  check_pre(clock?(clock1) && clock?(clock2))
#  
#  clock_day_sec(clock1) == clock_day_sec(clock2)
#end