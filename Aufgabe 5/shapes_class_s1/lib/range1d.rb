
#Range1d ::= Int x Int
def_class(:Range1d,[:first,:last]){
  def invariant?
    ((self.first).int? && (self.last).int?)
  end
  
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
}
