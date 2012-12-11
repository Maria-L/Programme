
class Clock
  
  #####CREATION#####
  #Creatig Classes in a easier way by typing ClassName[attributes]
  def self.[](*args)
    check_inv(self.new(*args))
  end
  
  #####PRAEDICATS#####
  #Hookmethod for the praedicat clock?
  def clock?
    true
  end
  
  def to_clock(clock)
    if    clock.clock_sec?  then self.to_clock_sec
    elsif clock.clock24?    then self.to_clock24
    elsif clock.clock12?    then self.to_clock12
    else check_pre(false)
    end
  end
  
  #####GET/TRANSFORMATIONS#####
  
  #Gets an hour24
  def hour24
    (self.to_clock24).hour24
  end
  
  #Gets an hour12
  def hour12
    (self.to_clock12).hour12
  end
  
  #Gets a min
  def min
    (self.to_clock24).min
  end
  
  #Gets a sec
  def sec
    (self.to_clock24).sec
  end
  
  #Gets a halve
  def halve
    (self.to_clock12).halve
  end
  
  #gets a clock_sec
  def day_sec
    (self.to_clock_sec).day_sec
  end
  
  #####METHODS#####
  
  #Adds two clocks
  #
  # add ::= (clock) :: ClockSec x Clock -> ClockSec |
  #                     Clock24 x Clock -> Clock24  |
  #                     Clock12 x Clock -> Clock12
  #                     
  #Test{ ClockSec[0].add(ClockSec[400]) => ClockSec[400],
  #ClockSec[400].add(ClockSec[0]) => ClockSec[400],
  #ClockSec[400].add(ClockSec[300]) => ClockSec[700]
  #ClockSec[86399].add(ClockSec[8400]) => ClockSec[8399]
  #ClockSec[400].add('a') => ERR, (ClockSec[400],5) => ERR,
  #Clock12[:AM,0,0,1].add(ClockSec[0]) => Clock12[:AM,0,0,1],
  #Clock12[:AM,1,0,0].add(Clock24[1,0,0] => Clock12[:AM,2,0,0])
  #Clock12[:AM,1,0,0].add(Clock12[:AM,4,0,0]) => Clock12[:AM,5,0,0]
  #Clock12[:PM,3,0,0].add(a) => Err)
  #Clock24[,0,0,1].add(ClockSec[0]) => Clock24[0,0,1],
  #Clock24[,1,0,0].add(Clock24[1,0,0] => Clock24[,2,0,0])
  #Clock24[,1,0,0].add(Clock12[:AM,4,0,0]) => Clock24[5,0,0]
  #Clock24[:PM,3,0,0].add(a) => Err)}
  #
  def add(clock)
    check_pre(clock.clock?)
    ClockSec[(((self.to_clock_sec).day_sec + (clock.to_clock_sec).day_sec)) % $DAY_IN_SEC].to_clock(self)
  end
  
  alias_method :+, :add
  
  #Substracts two clocks
  #
  #Adds two clocks
  #
  # add ::= (clock) :: ClockSec x Clock -> ClockSec |
  #                     Clock24 x Clock -> Clock24  |
  #                     Clock12 x Clock -> Clock12
  #                     
  #Test{ (ClockSec[400],ClockSec[400]) => ClockSec[0],
  #(ClockSec[400],ClockSec[0]) => ClockSec[400],
  #(ClockSec[400],ClockSec[300]) => ClockSec[100],
  #(ClockSec[0],ClockSec[1]) => ClockSec[86399],
  #(Clock24[1,2,3], ClockSec[400]) => Err,
  #Clock12[:AM,0,0,2].add(ClockSec[1]) => Clock12[:AM,0,0,1],
  #Clock12[:AM,2,0,0].add(Clock24[1,0,0] => Clock12[:AM,1,0,0])
  #Clock12[:AM,5,0,0].add(Clock12[:AM,4,0,0]) => Clock1[:AM,1,0,0]
  #Clock12[:PM,3,0,0].add(a) => Err),
  #Clock24[0,0,2].add(ClockSec[1]) => Clock24[0,0,1],
  #Clock24[2,0,0].add(Clock24[1,0,0] => Clock24[1,0,0])
  #Clock24[5,0,0].add(Clock12[:AM,4,0,0]) => Clock24[1,0,0]
  #Clock24[3,0,0].add(a) => Err)}
  #
  def sub(clock)
    check_pre(clock.clock?)
    ClockSec[(((self.to_clock_sec).day_sec - (clock.to_clock_sec).day_sec)) % $DAY_IN_SEC].to_clock(self)
  end
  
  alias_method :-, :sub
  
  #Calculates the successor of a clock
  #
  #succ ::= () :: Clock -> Clock
  #
  #Test{ClockSec[3600].succ => ClockSec[3601],
  #Clock12[:AM,0,0,1].succ => Clock12[:AM,0,0,2],
  #Clock24[0,0,1].succ => Clock24[0,0,2]}
  #
  def succ
    ((self.to_clock_sec).add(ClockSec[1])).to_clock(self)
  end
  
  #Calculates the predecessor of a clock
  #
  #pred ::= () :: Clock -> Clock
  #
  #Test{ClockSec[500].succ => ClockSec[501],
  #Clock12[:AM,0,0,1].succ => Clock12[:AM,0,0,2],
  #Clock24[0,0,2].succ => Clock24[0,0,1]}
  #
  def pred
    ((self.to_clock_sec).sub(ClockSec[1])).to_clock(self)
  end
  
  #Checks, whether two Clocks have the same value
  #
  #add ::= (clock) :: ClockSec x Clock -> ClockSec |
  #                     Clock24 x Clock -> Clock24  |
  #                     Clock12 x Clock -> Clock12
  #
  #Test {ClockSec[0].clock_equal(Clock12[:AM,0,0,0] => true,
  #     ClockSec[0].clock_equal(Clock24[0,0,0] => true,
  #     ClockSec[0].clock_equal(ClockSec[0] => true,
  #     ClockSec[0].clock_equal(Clock12[:AM,0,0,1] => false,
  #     ClockSec[0].clock_equal(Clock24[0,0,1] => false,
  #     ClockSec[0].clock_equal(ClockSec[1] => false,
  #     ClockSec[0].clock_equal('a') => false,
  #     Clock12[:AM,0,0,0].clock_equal(Clock12[:AM,0,0,0] => true,
  #     Clock12[:AM,0,0,0].clock_equal(Clock24[0,0,0] => true,
  #     Clock12[:AM,0,0,0].clock_equal(ClockSec[0] => true,
  #     Clock12[:AM,0,0,0].clock_equal(Clock12[:AM,0,0,1] => false,
  #     Clock12[:AM,0,0,0].clock_equal(Clock24[0,0,1] => false,
  #     Clock12[:AM,0,0,0].clock_equal(ClockSec[1] => false,
  #     Clock12[:AM,0,0,0].clock_equal('a') => false,
  #     Clock24[0,0,0].clock_equal(Clock12[:AM,0,0,0] => true,
  #     Clock24[0,0,0].clock_equal(Clock24[0,0,0] => true,
  #     Clock24[0,0,0].clock_equal(ClockSec[0] => true,
  #     Clock24[0,0,0].clock_equal(Clock12[:AM,0,0,1] => false,
  #     Clock24[0,0,0].clock_equal(Clock24[0,0,1] => false,
  #     Clock24[0,0,0].clock_equal(ClockSec[1] => false,
  #     Clock24[0,0,0].clock_equal('a') => false}
  #
  def clock_equal(clock)
    clock.clock? and (self.to_clock_sec).day_sec == (clock.to_clock_sec).day_sec
  end
  
  alias_method :==, :clock_equal
end
