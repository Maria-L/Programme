class ClockSec
  
  ####CREATION####

  #Creatig Classes in a easier way by typing ClassName[attributes]

  def self.[](*args)
    check_inv(self.new(*args))
  end

  #A funktion which uses the attributes from the class own funktion new to create a new object

  def initialize(day_sec)
    @day_sec = day_sec
  end
  
  #Checking the invariants
  
  def invariant?
    day_sec.day_sec?
  end
  
  ####PRAEDICATS####
  
  #Hookmethod for the praedicat clock?
  def clock?
    true
  end
  
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
  
  ####METHODS####
  
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

  #Calculate the succesor of a ClockSec
  #
  #succ
  #
  #Test{ClockSec[3600].succ => ClockSec[3601]}

  def succ
    self.add(ClockSec[1])
  end

  #Calculate the predeccesor of a ClockSec
  #
  #pred
  #
  #Test{ClockSec[500].succ => ClockSec[501]}

  def pred
    sub(ClockSec[1])
  end

  #Checks equality of a clock with another random Object in concerns of Values
  #
  #clock_equal ::= (clock) :: ClockSec x Any -> Bool
  #
  #Test {ClockSec[0].clock_equal(Clock12[:AM,0,0,0] => true,
  #     ClockSec[0].clock_equal(Clock24[0,0,0] => true,
  #     ClockSec[0].clock_equal(ClockSec[0] => true,
  #     ClockSec[0].clock_equal(Clock12[:AM,0,0,1] => false,
  #     ClockSec[0].clock_equal(Clock24[0,0,1] => false,
  #     ClockSec[0].clock_equal(ClockSec[1] => false,
  #     ClockSec[0].clock_equal('a') => false}
  #
  def clock_equal(clock)
    clock.clock? and self.day_sec == (clock.to_clock_sec).day_sec
  end
  
  alias_method :==, :clock_equal
end
