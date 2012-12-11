class Clock12 < Clock

  ####CREATION####

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
end