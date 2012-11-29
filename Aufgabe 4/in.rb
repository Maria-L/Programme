#Checks if a point be in a shape
#
#in? ::= (point,shape) :: Point x Shape -> Bool
#
#Test{  (1,Range1d[1,2]) => true, (1,Range1d[2,3]) => false, (0,Range1d[0,0] => true,
#       (Point2d[0,0],Range2d[Range1d[-1,5],Range1d[-1,3]]) => true, (Point2d[0,0],Range2d[Range1d[1,5],Range1d[1,3]]) => false,
#       (Point2d[0,0],Range2d[Range1d[0,0],Range1d[0,0]]) => true,
#       (1,Union1d[Range1d[1,2],Range1d[2,3]])=> true, (0,Union1d[Range1d[0,0],Range1d[0,0]]) => true,
#       (1,Union1d[Range1d[1,2],Range1d[2,3])=> false,
#       (Point2d[1,2],Union2d[Range2d[Range1d[1,2],Range1d[2,3]],Union2d[Range2d[Range1d[1,2],Range1d[2,3]],Range2d[Range1d[1,3],Range1d[2,6]]]]) => true,
#       (Point2d[-1,-2],Union2d[Range2d[Range1d[1,2],Range1d[2,3]],Union2d[Range2d[Range1d[1,2],Range1d[2,3]],Range2d[Range1d[1,3],Range1d[2,6]]]]) => false,
#       (Point2d[0,0],Union2d[Range2d[Range1d[0,0],Range1d[0,0]],Union2d[Range2d[Range1d[0,0],Range1d[0,0]],Range2d[Range1d[0,0],Range1d[0,0]]]]) => true,
#       (1,"a") => Err,
#       (Point2d[1,2],1)=> Err}


def in?(point,shape)
  check_pre((point.int? || point.point2d?) && shape?(shape))
  if    not(equal_dimension?(point,shape))  then false   
  elsif unionshape?(shape)                  then in?(point,shape.left) or in?(point,shape.right)
  elsif shape.range2d?                      then in?(point.x,shape.x_range) and in?(point.y,shape.y_range)
  elsif shape.range1d?                      then (shape.first..shape.last).include?(point)
  else check_pre(false)
  end
end
