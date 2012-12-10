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


#def_class(:MyClass,[:myVar])

#puts MyClass[8]

#p MyClass[9]

#puts ClockSec[2334] == ClockSec[2335]
#puts Clock24[12,25,12] == Clock24[1,25,40]
#p Clock12.new(:PM,4,52,32).add(Clock12.new(:PM,4,52,32))
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
