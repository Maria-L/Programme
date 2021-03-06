class Clock12

  ####CREATION####
     
  #Creatig Classes in a easier way by typing ClassName[attributes]

  def self.[](*args)
    check_inv(self.new(*args))
  end

  #A funktion which uses the attributes from the class own funktion new to create a new object

  def initialize(halve,hour12,min,sec)
    @halve = halve
    @hour12 = hour12
    @min = min
    @sec = sec
  end
  
  #Creatig Classes in a easier way by typing ClassName[attributes]
  def invariant?()
    halve.halve? and hour12.hour12? and min.min? and sec.sec?
  end
  
  ####PRAEDICATS####
  
  #Hookmethod for the praedicat clock?
  def clock?
    true
  end
  
  #Hookmethod for the praedicat clock12?
  def clock12?
    true
  end
  
  ####GET/TRANSFORMATIONS####
  
  # Method to transform the Class in a pretty string
  # Test {Clock12[:AM,1,2,3].to_s => "Clock12[AM,1,2,3]"}
  def to_s
    "#{self.class.name}[#{@halve},#{@hour12},#{@min},#{@sec}]"
  end
  
  #Gets an halve
  def halve
    @halve
  end
  
  #Gets an hour12
  def hour12
    @hour12
  end
  
  #Gets a min
  def min
    @min
  end
  
  #Gets a sec
  def sec
    @sec
  end
  
  #Gets an hour24
  def hour24
    (self.to_clock24).hour24
  end
  
  #Gets a day_sec
  def day_sec
    (self.to_clock_sec).day_sec
  end
  
  #Convert a Clock12 to ClockSec
  #
  #to_clock_sec ::= (clock) ::
  #Clock12 -> ClockSec
  #
  #Test {Clock12[:AM,0,0,0].to_clock_sec => ClockSec[0], clock12[:AM,1,2,3]to_clock_sec => ClockSec[3723]
  #Clock12[:PM,0,0,0]to_clock_sec => ClockSec[43200], Clock12[:PM,1,2,3]to_clock_sec => ClockSec[46923]}
  
  #def clock12_to_clock_sec_helper(clock)
  #  clock.min * $MIN_IN_SEC + clock.hour12 * $HOUR_IN_SEC + clock.sec
  #end
  
  def to_clock_sec
    if self.halve == :AM then ClockSec[self.min * $MIN_IN_SEC + self.hour12 * $HOUR_IN_SEC + self.sec]
    else                      ClockSec[self.min * $MIN_IN_SEC + self.hour12 * $HOUR_IN_SEC + self.sec + 12 * $HOUR_IN_SEC]
    end
  end

  #Convert a Clock12 to Clock12
  #
  #to_clock12 ::= (clock) ::
  #Clock12 -> Clock12
  #
  #Test {Clock12[:AM, 0, 0, 0] => Clock12[:AM, 0, 0, 0], clock12[:AM, 1, 2, 3] => clock12[:AM, 1, 2, 3]
  #Clock12[:PM, 0, 0, 0] => Clock12[:PM, 0, 0, 0], clock12[:PM, 1, 2, 3] => clock12[:PM, 1, 2, 3]
  #Clock24[1,2,3] => Err}

  def to_clock12
    Clock12[self.halve,self.hour12,self.min,self.sec]
  end
  
  #Converts a Clock12 to a Clock24
  #
  #clock12_to_clock24 ::= (clock) ::
  #Clock12 -> Clock24
  #
  #Test {Clock12[:AM,0,0,0] => Clock24[0,0,0], Clock12[:PM,0,0,0] => Clock24[12,0,0],
  #Clock12[:PM,1,2,3] => Clock24[13,2,3],
  #Clock24[1,2,3] => Err}

  def to_clock24
    if self.halve == :PM
      Clock24[self.hour12 + 12, self.min, self.sec]
    else
      Clock24[self.hour12, self.min, self.sec]
    end
  end

  
  ####METHODS####
  
  #Add two diverent clocks after converting into ClockSec
  #
  #add ::= (clock)::
  #Clock -> Clock12
  #
  #Test {Clock12[:AM,0,0,1].add(ClockSec[0]) => Clock12[:AM,0,0,1],Clock12[:AM,1,0,0].add(Clock24[1,0,0] => Clock12[:AM,2,0,0])
  #     Clock12[:AM,1,0,0].add(Clock12[:AM,4,0,0]) => Clock12[:AM,5,0,0]
  #     Clock12[:PM,3,0,0].add(a) => Err)}

  def add(clock)
    check_pre(clock.clock?)
    ((self.to_clock_sec).add(clock.to_clock_sec)).to_clock_12
  end

  #Subract two diverent clocks after converting into ClockSec
  #
  #add ::= (clock)::
  #Clock -> Clock12
  #
  #Test {Clock12[:AM,0,0,2].add(ClockSec[1]) => Clock12[:AM,0,0,1],Clock12[:AM,2,0,0].add(Clock24[1,0,0] => Clock12[:AM,1,0,0])
  #     Clock12[:AM,5,0,0].add(Clock12[:AM,4,0,0]) => Clock1[:AM,1,0,0]
  #     Clock12[:PM,3,0,0].add(a) => Err)}
  
  def sub(clock)
    check_pre(clock.clock?)
    ((self.to_clock_sec).sub(clock.to_clock_sec)).to_clock12
  end

  #Calculate the succesor of a Clock12
  #
  #succ ::= () :: Clock12 -> Clock12
  #
  #Test{Clock12[:AM,0,0,1].succ => Clock12[:AM,0,0,2]}

  def succ
    ((self.to_clock_sec).succ).to_clock12
  end

  #Calculate the predeccesor of a Clock12
  #
  #pred ::= () :: Clock12 -> Clock12
  #
  #Test{Clock12[:AM,0,0,2].succ => Clock12[:AM,0,0,1]}
 
  def pred
    ((self.to_clock_sec).pred).to_clock12
  end
  
  # Checks whether two Clocks are equal
  #
  # clock_equal ::= (Clock) :: Clock12 x Any -> Bool
  #
  #Test {Clock12[:AM,0,0,0].clock_equal(Clock12[:AM,0,0,0] => true,
  #     Clock12[:AM,0,0,0].clock_equal(Clock24[0,0,0] => true,
  #     Clock12[:AM,0,0,0].clock_equal(ClockSec[0] => true,
  #     Clock12[:AM,0,0,0].clock_equal(Clock12[:AM,0,0,1] => false,
  #     Clock12[:AM,0,0,0].clock_equal(Clock24[0,0,1] => false,
  #     Clock12[:AM,0,0,0].clock_equal(ClockSec[1] => false,
  #     Clock12[:AM,0,0,0].clock_equal('a') => false}
  #
  
  def clock_equal(clock)
    clock.clock? and (self.to_clock_sec).clock_equal(clock.to_clock_sec)
  end
  
  alias_method :==, :clock_equal
end