class ClockSec < Clock
  
  ####CREATION####


  #A funktion which uses the attributes from the class own funktion new to create a new object

  def initialize(day_sec)
    @day_sec = day_sec
  end
  
  #Checking the invariants
  
  def invariant?
    day_sec.day_sec?
  end
  
  ####PRAEDICATS####
  
  #Hookmethod for the praedicat clock_sec?
  def clock_sec?
    true
  end
  
  ####GET/TRANSFORMATIONS####
  
  # Method to transform the Class in a pretty string
  # Test {ClockSec[5].to_s => "ClockSec[5]"}
  def to_s
    "#{self.class.name}[#{@day_sec}]"
  end
  
  #Transforms to a ClockSec
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
  
  # Getter for day_sec
  # Test {ClockSec[5].day_sec => 5}
  def day_sec
    @day_sec
  end
end
