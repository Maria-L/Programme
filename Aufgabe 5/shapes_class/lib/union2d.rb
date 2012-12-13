#Union2d ::= Shape2d x Shape2d
class Union2d
  
  ####CREATION#####
  attr_reader :left, :right
  
  def self.[](*args)
    check_inv(self.new(*args))
  end
  
  def initialize(left, right)
    @left = left
    @right = right
  end
  
  def invariant?
    left.shape2d? && right.shape2d?
  end
  
  ####PRAEDICATS####
  def union2d?; true end
  def shape2d?; true end
  def shape?; true end
  def unionshape?; true end
  def compshape?; true end
  def unionshape?; true end
  def graphobj?; true end
  def two_dimensions?; true end
  
  ####METHODS####
  
  #translate_shape ::= (shape, point) :: Shape x Int -> Shape
  #                                      Shape x Point2d -> Shape
  #
  #TEST {(Range1d[5,6],1) => Range1d[6,7],
  #      (Union1d[Union1d[Range1d[1,2], Range1d[3,4]], Range1d[5,6]], 2) => Union1d[Union1d[Range1d[3,4], Range1d[5,6]], Range1d[6,7]],
  #      (Range2d[Range1d[1,2], Range2d[3,4]], Point2d[2,2]) => Range2d[Range1d[3,4], Range2d[5,6]],
  #      (Union2d[Union2d[Range2d[Range1d[2,3], Range1d[4,5]], Range2d[Range1d[7,8],Range1d[10,11]]], Range2d[Range1d[13,14], Range1d[16,17]]], Point2d[1,2]) => Union2d[Union2d[Range2d[Range1d[3,4], Range1d[6,7]], Range2d[Range1d[8,9],Range1d[12,13]]], Range2d[Range1d[14,15], Range1d[18,19]]],
  #      (Union2d[Range2d[Range1d[1,2], Range1d[3,4]]], 1) => Err,
  #      (Union1d[Range1d[1,2]], Point2d[1,2]) => Err}
  #
  
  def translate(point)
    check_pre(point.point? && self.equal_dimension?(point))
    Union2d[(self.left).translate(point),(self.right).translate(point)]
  end
  
  #Calculate the smalest bounding box over a figure
  #
  #bounds ::= (shape) :: Shape -> (Range1d|Range2d)
  #
  #Test{  (Range1d[1,2]) => Range1d[1,2], Range[0,0] => Range[0,0],
  #       (Range2d[Range1d[1,2],Range1d[2,3]]) => Range2d[Range1d[1,2],Range1d[2,3]], 
  #       (Range2d[Range1d[0,0],Range1d[0,0]) => Range2d[Range1d[0,0],Range1d[0,0]
  #       (Union1d[Range1d[1,2],Range1d[2,3]]) => Range1d[1,3],
  #       (Union1d[Range1d[0,0],Range1d[0,0]]) => Range1d[0,0],
  #       (Union2d[Union2d[Range2d[Range1d[1,2]), Range1d[3,4]], Range2d[Range1d[5,6], Range1d[7,8]]],Range2d[Range1d[9,10], Range1d[11,12]]]) => Range2d[Range1d[1,10],Range1d[3,12]],
  #       (Union2d[Union2d[Range2d[Range1d[0,0]), Range1d[0,0]], Range2d[Range1d[0,0], Range1d[0,0]]],Range2d[Range1d[0,0], Range1d[0,0]]]) => Range2d[Range1d[0,0],Range1d[0,0]]
  #       ("a") => Err}
  #
  def bounds
    ((self.left).bounds).bounding_range((self.right).bounds)
  end
  
  #Checks, whether a point is in the range.
  #assert_equal(true, Union2d[Range2d[Range1d[1,2],Range1d[2,3]],Union2d[Range2d[Range1d[1,2],Range1d[2,3]],Range2d[Range1d[1,3],Range1d[2,6]]]].in?(Point2d[1,2]))
  #assert_equal(false, Union2d[Range2d[Range1d[1,2],Range1d[2,3]],Union2d[Range2d[Range1d[1,2],Range1d[2,3]],Range2d[Range1d[1,3],Range1d[2,6]]]].in?(Point2d[-1,-2]))
  #assert_equal(true, Union2d[Range2d[Range1d[0,0],Range1d[0,0]],Union2d[Range2d[Range1d[0,0],Range1d[0,0]],Range2d[Range1d[0,0],Range1d[0,0]]]].in?(Point2d[0,0]))
  #
  def in?(point)
    check_pre(point.point?)
    (self.left).in?(point) or (self.right).in?(point)
  end
  
  def graph_equal?(o)
    o.union2d? && (self.left).graph_equal?(o.left) && (self.right).graph_equal?(o.right)
  end
  
  alias_method :==, :graph_equal?
  
  def graph_equal_trans?(o)
    o.graphobj? &&
      self.translate(self.lower_left).graph_equal?(o.translate(o.lower_left))
  end
  
  def lower_left
    Point2d[-((self.bounds).x_range.first), -((self.bounds).y_range.first)]
  end
  
  def to_s
    "#{self.class.name} [#{left.to_s},#{right.to_s}]"
  end
end
