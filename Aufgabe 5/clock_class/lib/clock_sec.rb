def_class(:ClockSec,[:day_sec]){
  
  def invariant?()
    day_sec.day_sec?
  end
  
  def clock?
    true
  end
  
  def to_clock_sec
    ClockSec[self.day_sec]
  end
  
  #Conversts a ClockSec to a Clock12
  #
  #clock_sec_to_clock12 ::= (clock) ::
  #ClockSec -> Clock12
  #
  #Test [ClockSec[0] => Clock12[:AM,0,0,0], ClockSec[100] => Clock12[:AM,0,1,40],
  #ClockSec[43200] => Clock12[:PM,0,0,0], ClockSec[43300] => Clock12[:PM,0,1,40],
  #Clock24[1,2,3] => Err}

  def to_clock12
    sec = self.day_sec % $MIN_IN_SEC
    min = ((self.day_sec - sec) / $MIN_IN_SEC) % $HOUR_IN_MIN
    hour = (((self.day_sec - sec) / $MIN_IN_SEC) - min) / $HOUR_IN_MIN
    
    if hour >= 12 then Clock12[:PM, hour - 12, min, sec]
    else               Clock12[:AM, hour, min, sec]
    end
  end
  #Converts a ClockSec to a Clock24
  #
  #clock_sec_to_clock24 ::= (clock) ::
  #ClockSec -> Clock24
  #
  #Test {ClockSec[0] => Clock24[0,0,0], ClockSec[100] => Clock24[0,1,40],
  #Clock24[100] => Err}

  def to_clock24
    sec = self.day_sec % $MIN_IN_SEC
    min = ((self.day_sec - sec) / $MIN_IN_SEC) % $HOUR_IN_MIN
    hour = (((self.day_sec - sec) / $MIN_IN_SEC) - min) / $HOUR_IN_MIN
    
    Clock24[hour, min, sec]
  end

  def hour24
    (self.to_clock24).hour24
  end
  
  def hour12
    (self.to_clock12).hour12
  end
  
  def min
    (self.to_clock24).min
  end
  
  def sec
    (self.to_clock24).sec
  end
  
  def halve
    (self.to_clock12).halve
  end
  
  
  #Adds two differrent second clocks
  #
  #ClockSec#add ::= (clock) ::
  #ClockSec x ClockSec -> ClockSec
  #Test{ ClockSec[0].add(ClockSec[400]) => ClockSec[400],
  #ClockSec[400].add(ClockSec[0]) => ClockSec[400],
  #ClockSec[400].add(ClockSec[300]) => ClockSec[700]
  #ClockSec[86399].add(ClockSec[8400]) => ClockSec[8399]
  #ClockSec[400].add('a') => ERR, (ClockSec[400],5) => ERR}

  def add (clock)
    check_pre(clock.clock?)
    ClockSec[(self.day_sec + (clock.to_clock_sec).day_sec) % $DAY_IN_SEC]
  end

  #Substidude two differrent second clocks
  #
  #clock_sec_sub ::= (clock1, clock2) ::
  #ClockSec x ClockSec -> ClockSec ::::

  #
  #Test{ (ClockSec[400],ClockSec[400]) => ClockSec[0],
  #(ClockSec[400],ClockSec[0]) => ClockSec[400],
  #(ClockSec[400],ClockSec[300]) => ClockSec[100],
  #(ClockSec[0],ClockSec[1]) => ClockSec[86399],
  #
  #(Clock24[1,2,3], ClockSec[400]) => Err}

  def sub (clock)
    check_pre(clock.clock?)
    ClockSec[(self.day_sec - (clock.to_clock_sec).day_sec) % $DAY_IN_SEC]
  end

  def succ
    self.add(ClockSec[1]) 
  end

  def pred
    sub(ClockSec[1])
  end

  def clock_equal(clock)
    check_pre(clock.clock?)
    self == (clock.to_clock_sec)
  end
}