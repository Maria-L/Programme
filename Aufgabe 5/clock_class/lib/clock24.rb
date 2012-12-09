class Clock24
  
          ####CREATION####

  #A Funktion to makes the creation of a Class easyer by using the phrase ClassName[Atributes]
  def self.[](*args)
    check_inv(self.new(*args))
  end

  #A funktion which use the attributes from the class own funktion new. to create a new object
  def initialize(hour24, min, sec)
    @hour24 = hour24
    @min = min
    @sec = sec
  end
  
  def invariant?
    self.hour24.hour24?
    self.min.min?
    self.sec.sec?
  end
    
          ####PRAEDICATS####
  def clock?
    true
  end
  
  def clock24?
    true
  end
  
          ####GET/TRANSFORMATIONS####
  def to_s
    "#{self.class.name}[#{@hour24}, #{@min}, #{@sec}]"
  end        
  
  def hour24
    @hour24
  end
  
  def min
    @min
  end
  
  def sec
    @sec
  end
  
  def hour12
    (self.to_clock12).hour12
  end
  
  def halve
    (self.to_clock12).halve
  end
  
  def day_sec
    (self.to_clock_sec).day_sec
  end
  
  #Convert a clock24 to clock_sec
  #
  #clock24_to_clock_sec ::= (clock) ::
  #Clock24 -> ClockSec
  #
  #Test {Clock24[0,0,0] => ClockSec[0], Clock24[1,2,3] => ClockSec[3723]
  #ClockSec[123] => Err}
  
  def to_clock_sec
    ClockSec[self.min * $MIN_IN_SEC + self.hour24 * $HOUR_IN_SEC + self.sec]
  end
  
  
  #Converts a Clock24 to a Clock12
  #
  #clock24_to_clock12 ::= (clock) ::
  #Clock24 -> Clock12
  #
  #Test {Clock24[0,0,0] => Clock12[:AM,0,0,0], Clock24[12,0,0] => Clock12[:PM,0,0,0],
  #Clock24[1,2,3] => Clock12[:AM,1,2,3]
  #Clock12[:AM,1,2,3] => Err
  
  def to_clock12
    if self.hour24 >= 12 then Clock12[:PM, self.hour24 - 12, self.min, self.sec]
    else                      Clock12[:AM, self.hour24, self.min, self.sec]
    end
  end

  #Converts a Clock to a Clock24
  #
  #to_clock24 ::= (clock) ::
  #Clock -> Clock24
  #
  #Test {Clock24[0,0,0] => Clock24[0,0,0], Clock12[:PM,0,0,0] => Clock24[12,0,0],
  #Clock12[:AM,1,2,3] => Clock24[1,2,3], ClockSec[3723] => Clock24[1,2,3]
  #Clock12[:AM,1,2,3] => Err
  
  def to_clock24
    Clock24[self.hour24,self.min,self.sec]
  end
  
          ####METHODS####

  #Add two diverent clocks after converting into Clock24
  #
  #add ::= (clock)::
  #Clock -> Clock24
  #
  #Test {Clock24[,0,0,1].add(ClockSec[0]) => Clock24[0,0,1],Clock24[,1,0,0].add(Clock24[1,0,0] => Clock24[,2,0,0])
  #     Clock24[,1,0,0].add(Clock12[:AM,4,0,0]) => Clock24[5,0,0]
  #     Clock24[:PM,3,0,0].add(a) => Err)}

  def add(clock)
    check_pre(clock.clock?)
    ((self.to_clock_sec).add(clock.to_clock_sec)).to_clock24
  end

  #Subract two diverent clocks after converting into ClockSec
  #
  #add ::= (clock)::
  #Clock -> Clock24
  #
  #Test {Clock24[0,0,2].add(ClockSec[1]) => Clock24[0,0,1],Clock24[2,0,0].add(Clock24[1,0,0] => Clock24[1,0,0])
  #     Clock24[5,0,0].add(Clock12[:AM,4,0,0]) => Clock24[1,0,0]
  #     Clock24[3,0,0].add(a) => Err)}
  
  def sub(clock)
    check_pre(clock.clock?)
    ((self.to_clock_sec).sub(clock.to_clock_sec)).to_clock24
  end

  #Calculate the succesor of a Clock24
  #
  #succ
  #
  #Test{Clock24[0,0,1].succ => Clock24[0,0,2]}

  def succ
    ((self.to_clock_sec).succ).to_clock24
  end

  #Calculate the predeccesor of a Clock24
  #
  #succ
  #
  #Test{Clock24[0,0,2].succ => Clock24[0,0,1]}
  
  def pred
    ((self.to_clock_sec).pred).to_clock24
  end
  
  def clock_equal(clock)
    check_pre(clock.clock?)
    (self.to_clock_sec).clock_equal(clock.to_clock_sec)
  end
  
  alias_method :==, :clock_equal
end