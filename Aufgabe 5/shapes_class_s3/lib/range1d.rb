
#Range1d ::= Int x Int
class Range1d
  
  
  ####CREATION#####
  
  attr_reader :first, :last
  
  def self.[](*args)
    check_inv(self.new(*args))
  end
  
  def initialize(first, last)
    @first = first
    @last = last
  end
  
  def invariant?
    ((@first).int? && (@last).int?)
  end
  
  ####PRAEDICATS####
   def range1d?; true end
   def shape1d?; true end
   def shape?; true end
   def primshape?; true end
   def graphobj?; true end
   def one_dimension?; true end
   
   
   
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
    Range1d[self.first + point, self.last + point]
  end
  
  def bounds()
    self
  end
  
  #bounding_range ::=(range1, range2) :: Range1d x Range1d -> Range1d |
  #                                      Range2d x Range2d -> Range2d
  def bounding_range(range)
    check_pre(range.primshape? && range.primshape? && self.equal_dimension?(range))
    Range1d[(self.first <= range.first ? self.first : range.first), (self.last >= range.last ? self.last : range.last)]
  end
  
  #Checks, whether a point is in the range.
  #assert_equal(true, Range1d[1,2].in?(1))
  #assert_equal(false, Range1d[2,3].in?(1))
  #assert_equal(true, Range1d[0,0].in?(0))
  def in?(point)
    check_pre(point.point?)
    (self.first..self.last).include?(point)
  end
  
  def graph_equal?(o)
    o.range1d? && (self.first == o.first) && (self.last == o.last)
  end
  
  alias_method :==, :graph_equal?
  
  def graph_equal_trans?(o)
    o.graphobj? &&
      self.translate(self.lower_left).graph_equal?(o.translate(o.lower_left))
  end
  
  def lower_left
    -(self.first)
  end
 
  def to_s
    "#{self.class.name} [#{first},#{last}]"
  end
end
