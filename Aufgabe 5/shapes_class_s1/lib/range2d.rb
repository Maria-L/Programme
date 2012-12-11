#Range2d ::= Range1d x Range1d
def_class(:Range2d,[:x_range,:y_range]){
  def invariant?
    (self.x_range.range1d? && self.y_range.range1d?)
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
    Range2d[self.x_range.translate(point.x), self.y_range.translate(point.y)]
  end
  
  
  def bounds()
    self
  end
  
  #bounding_range ::=(range1, range2) :: Range1d x Range1d -> Range1d |
  #                                      Range2d x Range2d -> Range2d
  def bounding_range(range)
    check_pre(range.primshape? && range.primshape? && self.equal_dimension?(range))
    Range2d[(self.x_range).bounding_range(range.x_range), (self.y_range).bounding_range(range.y_range)]
  end
  
  #Checks, whether a point is in the range.
  #assert_equal(true, Range2d[Range1d[-1,5],Range1d[-1,3]].in?(Point2d[0,0]))
  #assert_equal(false, Range2d[Range1d[1,5],Range1d[1,3]].in?(Point2d[0,0]))
  #assert_equal(true, Range2d[Range1d[0,0],Range1d[0,0]].in?(Point2d[0,0]))
  #
  def in?(point)
    check_pre(point.point?)
    (self.x_range).in?(point.x) and (self.y_range).in?(point.y)
  end
}
