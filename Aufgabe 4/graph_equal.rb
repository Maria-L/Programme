#Checks, if two Points are the same in shape, position and structure
#graph_equal_point1d ::= (o1,o2) :: Int x Int -> Bool
def graph_equal_point1d(o1,o2)
  check_pre(o1.int? && o2.int?)
  o1 == o2
end
#
##Checks, if two two-dimensional Points are the same in shape, position and structure
##graph_equal_point2d ::= (o1,o2) :: Point2d x Point2d -> Bool
#def graph_equal_point2d(o1,o2)
#  check_pre(o1.point2d? && o2.point2d?)
#  (o1.x == o2.x) && (o1.y == o2.y)
#end

#Checks, if two range1ds are the same in shape, position and structure
#graph_equal_range1d? ::= (o1,o2) :: Range1d x Range1d -> Bool
def graph_equal_range1d? (o1,o2)
  if o1.range1d? && o2.range1d?
    graph_equal_point1d(o1.first,o2.first) && graph_equal_point1d(o1.last,o2.last)
  elsif o1.union1d? && o2.union1d?
    graph_equal_union1d?(o1,o2)
  else false
  end
end

#Checks, if two range2ds are the same in shape, position and structure
#graph_equal_range2d? ::= (o1,o2) :: Range2d x Range2d -> Bool
def graph_equal_range2d?(o1,o2)
  if o1.range2d? && o2.range2d?
    graph_equal_range1d?(o1.x_range, o2.x_range) && graph_equal_range1d?(o1.y_range, o2.y_range)
  elsif o1.union2d? && o2.union2d?
    graph_equal_union2d?(o1,o2)
  else false
  end
end

#Checks, if two union1ds are the same in shape, position and structure
#graph_equal_union1d? ::= (o1,o2) :: Union1d x Union1d -> Bool
def graph_equal_union1d?(o1,o2)
  check_pre(shape1d?(o1) && shape1d?(o2))
  graph_equal_range1d?(o1.left, o2.left) && graph_equal_range1d?(o1.right, o2.right)
end

#Checks, if two range2ds are the same in shape, position and structure
#graph_equal_union2d? ::= (o1,o2) :: Union2d x Union2d -> Bool
def graph_equal_union2d?(o1,o2)
  check_pre(shape2d?(o1)&& shape2d?(o2))
  graph_equal_range2d?(o1.left, o2.left) && graph_equal_range2d?(o1.right, o2.right)
end

#Checks, if two Graphic Objects are the same in shape, position and structure
#graph_equal_? ::= (o1,o2) :: GraphObj x GraphObj -> Bool
#Test {(0,Range1d[1,2]) => false,
#      (Range1d[0,0], Range1d[0,0]) => true, (Range1d[1,2], Range1d[2,3]) => false,
#      (Range2d[Range1d[0,0], Range1d[0,0]], Range2d[Range1d[0,0], Range1d[0,0]]) => true, 
#      (Range2d[Range1d[0,0], Range1d[0,0]], Range2d[Range1d[0,0], Range1d[0,1]]) => false,
#      (Union1d[Union1d[Range1d[0,0], Range1d[1,2]], Range1d[2,3]], Union1d[Union1d[Range1d[0,0], Range1d[1,2]], Range1d[2,3]]) => true,
#      (Union1d[Union1d[Range1d[0,0], Range1d[1,2]], Range1d[2,3]], Union1d[Union1d[Range1d[0,0], Range1d[1,2]], Range1d[2,4]]) => false,
#      (Union2d[Union2d[Range2d[Range1d[2,3], Range1d[4,5]], Range2d[Range1d[7,8],Range1d[10,11]]], Range2d[Range1d[13,14], Range1d[16,17]]], Union2d[Union2d[Range2d[Range1d[2,3], Range1d[4,5]], Range2d[Range1d[7,8],Range1d[10,11]]], Range2d[Range1d[13,14], Range1d[16,17]]]) => true,
#      (Union2d[Union2d[Range2d[Range1d[2,3], Range1d[4,5]], Range2d[Range1d[7,8],Range1d[10,11]]], Range2d[Range1d[13,14], Range1d[16,17]]], Union2d[Union2d[Range2d[Range1d[2,3], Range1d[4,5]], Range2d[Range1d[7,8],Range1d[10,11]]], Range2d[Range1d[13,14], Range1d[16,18]]]) => false,
#      ("a", 0) => Err, (0,"a") => Err}
#
def graph_equal_?(o1,o2)
  check_pre(graphobj?(o1) && graphobj?(o2))
  if o1.range1d? && o2.range1d?
    graph_equal_range1d?(o1,o2)
  elsif o1.union1d? && o2. union1d?
    graph_equal_union1d?(o1,o2)
  elsif o1.range2d? && o2.range2d?
    graph_equal_range2d?(o1,o2)
  elsif o1.union2d? && o2.union2d?
    graph_equal_union2d?(o1,o2)
    #  elsif o1.int? && o2.int?
    #    graph_equal_point1d(o1,o2)
    #  elsif o1.point2d? && o2.point2d?
    #    graph_equal_point2d(o1,o2)
  else false
  end
end

#Checks, if two Objects are the same in shape, position and structure
#graph_equal? ::= (o1,o2) :: Any x Any ->? Bool
#Test {(0,Range1d[1,2]) => false,
#      (Range1d[0,0], Range1d[0,0]) => true, (Range1d[1,2], Range1d[2,3]) => false,
#      (Range2d[Range1d[0,0], Range1d[0,0]], Range2d[Range1d[0,0], Range1d[0,0]]) => true, 
#      (Range2d[Range1d[0,0], Range1d[0,0]], Range2d[Range1d[0,0], Range1d[0,1]]) => false,
#      (Union1d[Union1d[Range1d[0,0], Range1d[1,2]], Range1d[2,3]], Union1d[Union1d[Range1d[0,0], Range1d[1,2]], Range1d[2,3]]) => true,
#      (Union1d[Union1d[Range1d[0,0], Range1d[1,2]], Range1d[2,3]], Union1d[Union1d[Range1d[0,0], Range1d[1,2]], Range1d[2,4]]) => false,
#      (Union2d[Union2d[Range2d[Range1d[2,3], Range1d[4,5]], Range2d[Range1d[7,8],Range1d[10,11]]], Range2d[Range1d[13,14], Range1d[16,17]]], Union2d[Union2d[Range2d[Range1d[2,3], Range1d[4,5]], Range2d[Range1d[7,8],Range1d[10,11]]], Range2d[Range1d[13,14], Range1d[16,17]]]) => true,
#      (Union2d[Union2d[Range2d[Range1d[2,3], Range1d[4,5]], Range2d[Range1d[7,8],Range1d[10,11]]], Range2d[Range1d[13,14], Range1d[16,17]]], Union2d[Union2d[Range2d[Range1d[2,3], Range1d[4,5]], Range2d[Range1d[7,8],Range1d[10,11]]], Range2d[Range1d[13,14], Range1d[16,18]]]) => false,
#      ("a", 0) => false, (0,"a") => false, ("a", 'b') => Err}
#
def graph_equal?(o1,o2)
  check_pre(graphobj?(o1) || graphobj?(o2))
  if (not(graphobj?(o1))) || (not(graphobj?(o2)))
    false
  else
    graph_equal_?(o1,o2)
  end
end

#Calculates the lower left corner of a 2d Shape
#lower_left ::= (obj) :: Range2d -> Point2d |
#                        Union2d -> Point2d
def lower_left(obj)
  check_pre(graphobj?(obj))
  if one_dimension?(obj)
    (-(bounds(obj)).first)
  else
    Point2d[-(bounds(obj).x_range.first), -(bounds(obj).y_range.first)]
  end

end

#Checks, if two Objects are the same in shape and structure, but not necessarily in position
##graph_equal_trans? ::= (o1,o2) :: Any x Any ->? Bool
#Test {(0,0) => true, (Point2d[0,0], Point2d[0,0]) => true, (Point2d[1,2], Point2d[2,3]) => true, (0,Point2d[1,2]) => false,
#      (Range1d[0,0], Range1d[0,0]) => true, (Range1d[1,2], Range1d[2,3]) => true,
#      (Range2d[Range1d[0,0], Range1d[0,0]], Range2d[Range1d[1,1], Range1d[1,1]]) => true, 
#      (Range2d[Range1d[0,0], Range1d[0,0]], Range2d[Range1d[1,1], Range1d[1,2]]) => false,
#      (Union1d[Union1d[Range1d[0,0], Range1d[1,2]], Range1d[2,3]], Union1d[Union1d[Range1d[1,1], Range1d[2,3]], Range1d[3,4]]) => true,
#      (Union1d[Union1d[Range1d[0,0], Range1d[1,2]], Range1d[2,3]], Union1d[Union1d[Range1d[1,1], Range1d[2,3]], Range1d[3,5]]) => false,
#      (Union2d[Union2d[Range2d[Range1d[2,3], Range1d[4,5]], Range2d[Range1d[7,8],Range1d[10,11]]], Range2d[Range1d[13,14], Range1d[16,17]]], Union2d[Union2d[Range2d[Range1d[3,4], Range1d[5,6]], Range2d[Range1d[8,9],Range1d[11,12]]], Range2d[Range1d[14,15], Range1d[17,18]]]) => true,
#      (Union2d[Union2d[Range2d[Range1d[2,3], Range1d[4,5]], Range2d[Range1d[7,8],Range1d[10,11]]], Range2d[Range1d[13,14], Range1d[16,17]]], Union2d[Union2d[Range2d[Range1d[3,4], Range1d[5,6]], Range2d[Range1d[8,9],Range1d[11,12]]], Range2d[Range1d[14,15], Range1d[17,19]]]) => false,
#      ("a", 0) => false, (0,"a") => false, ("a", 'b') => Err}
def graph_equal_trans?(o1,o2)
  check_pre(graphobj?(o1) || graphobj?(o2))
  if (not(graphobj?(o1))) || (not(graphobj?(o2)))
    false
  else
    graph_equal?(translate(o1, lower_left(o1)), translate(o2, lower_left(o2)))
  end
end
