class Object
  def clock?
    false
  end
  
  def clock_sec?
    false
  end
  
  def clock24?
    false
  end
  
  def clock12?
    false
  end
  
  def day_sec?
    self.nat? and self < $DAY_IN_SEC
  end
  
  def hour24?
    false
  end
  
  def min?
    false
  end

  def sec?
    false
  end

  def hour12?
    false
  end
  
  def halve?
    false
  end
end

class Int
  #To check the legality of the insert Numbers
  #obj < $DAY_IN_SEC and obj >= 0
  #day_sec? ::== (obj) :: 
  #Any -> Bool ::
  #
  #
  # Test{ 3 => true, 0 => true, 86399 => true,
  # -3 => false , 86500 => false,
  # "a" => false  }

  def day_sec?
    self.nat? and self < $DAY_IN_SEC
  end
  
  #To check the legality of the insert Numbers
  #obj < $DAY_IN_HOUR and obj >= 0
  #hour24? ::== (obj) :: 
  #Any -> Bool ::
  #
  #
  # Test{ 3 => true, 0 => true, 23 => true,
  # -3 => false , 24 => false,
  # "a" => false  }

  def hour24?
    self.nat? and self < $DAY_IN_HOUR 
  end

  #To check the legality of the insert Numbers
  #obj < $HOUR_IN_MIN and obj >= 0
  #min? ::== (obj) :: 
  #Any -> Bool ::
  #
  #
  # Test{ 3 => true, 0 => true, 59 => true,
  # -3 => false , 60 => false,
  # "a" => false }

  def min?
    self.nat? and self < $HOUR_IN_MIN
  end

  #To check the legality of the insert Numbers
  #obj < $MIN_IN_SEC and obj >= 0
  #sec? ::== (obj) :: 
  #Any -> Bool ::
  #
  #
  # Test{ 3 => true, 0 => true, 59 => true,
  # -3 => false , 60 => false,
  # "a" => false }

  def sec?
    self.nat? and self < $MIN_IN_SEC
  end


  #To check the legality of the insert Numbers
  #obj <= 11 and obj >= 0
  #hour12? ::== (obj) :: 
  #Any -> Bool ::
  #
  #
  # Test{ 3 => true, 0 => true, 11 => true,
  # -3 => false , 12 => false,
  # "a" => false }

  def hour12?
    self.nat? and self <= 11
  end
end

class Symbol
  #To check the legality of the insert Symbols
  #obj = :AM || obj = :PM
  #halve? ::== (obj) ::
  #Any -> Bool ::
  #
  #
  #Test{ :AM => true, :PM => true
  #   :Text => false, 5 => false, "a" => false}


  def halve?
    self == :AM or self == :PM
  end
end