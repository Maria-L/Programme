#Point2d ::= Point1d x Point1d
class Point2d < Point
  
  ####CREATION#####
  attr_reader :x, :y
  
  def initialize (x, y)
    @x = x
    @y = y
  end
  
  def invariant?
    (x.int? && y.int?)
  end
  
  ####PRAEDICATS####
  def point2d?; true end
  def two_dimensions?; true end
  

end
