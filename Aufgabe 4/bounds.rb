
#bounding_range ::=(range1, range2) :: Range1d x Range1d -> Range1d |
#                                      Range2d x Range2d -> Range2d
def bounding_range(range1, range2)
  check_pre(primshape?(range1) && primshape?(range2) && equal_dimension?(range1, range2))
  if    range1.range1d?     then Range1d[(range1.first <= range2.first ? range1.first : range2.first), (range1.last >= range2.last ? range1.last : range2.last)]
  elsif range1.range2d?     then Range2d[bounding_range(range1.x_range, range2.x_range), bounding_range(range1.y_range, range2.y_range)]
  end
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

def bounds(shape)
  if unionshape?(shape) then bounding_range(bounds(shape.left), bounds(shape.right))
  elsif primshape?(shape) then shape
  else check_pre(false)
  end
  
end
