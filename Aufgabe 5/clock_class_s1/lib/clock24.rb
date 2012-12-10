def_class(:Clock24,[:hour24,:min,:sec]){
  
  def invariant?()
    hour24.hour24? and min.min? and sec.sec?
  end
    
  def clock?
    true
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
  
  def to_clock24
    Clock24[self.hour24,self.min,self.sec]
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
  
  
  
  def add(clock)
    check_pre(clock.clock?)
    ((self.to_clock_sec).add(clock.to_clock_sec)).to_clock24
  end
  
  def sub(clock)
    check_pre(clock.clock?)
    ((self.to_clock_sec).sub(clock.to_clock_sec)).to_clock24
  end
  
  def succ
    ((self.to_clock_sec).succ).to_clock24
  end
  
  def pred
    ((self.to_clock_sec).pred).to_clock24
  end
  
  def clock_equal(clock)
    check_pre(clock.clock?)
    (self.to_clock_sec).clock_equal(clock.to_clock_sec)
  end
}