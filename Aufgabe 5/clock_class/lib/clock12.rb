def_class(:Clock12,[:halve,:hour12,:min,:sec]){
  
  def invariant?()
    halve.halve? and hour12.hour12? and min.min? and min.sec?
  end
  
  def clock?
    true
  end
  #Convert a Clock12 to ClockSec
  #
  #clock12_to_clock_sec ::= (clock) ::
  #Clock12 -> ClockSec
  #
  #Test {Clock12[:AM, 0, 0, 0] => ClockSec[0], clock12[:AM, 1, 2, 3] => ClockSec[3723]
  #Clock12[:PM, 0, 0, 0] => ClockSec[43200], clock12[:PM, 1, 2, 3] => ClockSec[46923]
  #Clock24[1,2,3] => Err}
  #
  
  #def clock12_to_clock_sec_helper(clock)
  #  clock.min * $MIN_IN_SEC + clock.hour12 * $HOUR_IN_SEC + clock.sec
  #end
  def to_clock_sec
    if self.halve == :AM then ClockSec[self.min * $MIN_IN_SEC + self.hour12 * $HOUR_IN_SEC + self.sec]
    else                      ClockSec[self.min * $MIN_IN_SEC + self.hour12 * $HOUR_IN_SEC + self.sec + 12 * $HOUR_IN_SEC]
    end
  end
  
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
 
    def hour24
    (self.to_clock24).hour24
  end
  
  def day_sec
    (self.to_clock_sec).day_sec
  end
  
  def add(clock)
    check_pre(clock.clock?)
    ((self.to_clock_sec).add(clock.to_clock_sec)).to_clock_12
  end
  
  def sub(clock)
    check_pre(clock.clock?)
    ((self.to_clock_sec).sub(clock.to_clock_sec)).to_clock12
  end
  
  def succ
    ((self.to_clock_sec).succ).to_clock12
  end
  
  def pred
    ((self.to_clock_sec).pred).to_clock12
  end
  
  def clock_equal(clock)
  check_pre(clock.clock?)
  (self.to_clock_sec) == (clock.to_clock_sec)
  end
}