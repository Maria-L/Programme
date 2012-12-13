class Diff2d < Shape
  
  ####CREATION#####
  
  attr_reader :left, :right
  
  def initialize(left, right)
    @left = left
    @right = right
  end
  
  def invariant?
    left.shape2d? && right.shape2d?
  end
  
  def translate(point)
    check_pre(point.point? && self.equal_dimension?(point))
    self.class[(self.left).translate(point),(self.right).translate(point)]
  end
  
  def bounds
    (self.left).bounds
  end
  
   def in?(point)
    check_pre(point.point?)
    (self.left).in?(point) and not (self.right).in?(point)
  end
  
  def graph_equal?(o)
    o.diff2d? && (self.left).graph_equal?(o.left) && (self.right).graph_equal?(o.right)
  end
  
  def lower_left
    Point2d[-((self.bounds).x_range.first), -((self.bounds).y_range.first)]
  end
  
  def to_s
    "#{self.class.name} [#{left.to_s},#{right.to_s}]"
  end
  
end
