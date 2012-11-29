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

def translate(shape, point)
  check_pre(shape?(shape) && point?(point) && equal_dimension?(shape, point))
  
  if shape.range1d? then Range1d[shape.first + point, shape.last + point]
  elsif shape.range2d? then Range2d[translate(shape.x_range,point.x),translate(shape.y_range,point.y)]
  elsif shape.union1d? then Union1d[translate(shape.left,point),translate(shape.right,point)]
  elsif shape.union2d? then Union2d[translate(shape.left,point),translate(shape.right,point)]
  elsif false
  end
end