#Point2d ::= Point1d x Point1d
class Point2d 
  
  ####CREATION#####
  attr_reader :x, :y
  
  def self.[](*args)
    check_inv(self.new(*args))
  end
  
  def initialize (x, y)
    @x = x
    @y = y
  end
  
  def invariant?
    (x.int? && y.int?)
  end
  
  ####PRAEDICATS####
  def point2d?; true end
  def point?; true end
  def two_dimensions?; true end
  
  ####METHODS####
  
  def to_s
    "#{self.class.name} [#{x}, #{y}]"
  end
end
