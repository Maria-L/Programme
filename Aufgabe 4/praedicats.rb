#shape1d? ::= (x) :: Any -> Bool
def shape1d?(x)
  x.range1d? || x.union1d?
end

#shape2d? ::= (x) :: Any -> Bool
def shape2d?(x)
  x.range2d? || x.union2d?
end

#point? ::= (x) :: Any -> Bool
def point?(x)
  x.int? || x.point2d?
end

#shape? ::= (x) :: Any -> Bool
def shape?(x)
  primshape?(x) || compshape?(x)
end

#primshape ::= (x) :: Any -> Bool
def primshape?(x)
  x.range1d? || x.range2d?
end

#compshape ::= (x) :: Any -> Bool
def compshape?(x)
  unionshape?(x)
end

#unionshape ::= (x) :: Any -> Bool
def unionshape?(x)
  x.union1d? || x.union2d?
end

#graphobj ::= (x) :: Any -> Bool
def graphobj?(x)
  point?(x) || shape?(x)
end

#one_dimension? ::= (x) :: Any -> Bool
def one_dimension?(x)
  shape1d?(x) || x.range1d? || x.int? || x.union1d?
end

#two_dimensions? ::= (x) :: Any -> Bool
def two_dimensions?(x)
  shape2d?(x) || x.range2d? || x.point2d? ||  x.union2d?
end

#equal_dimension? ::= (x,y) :: Any x Any -> Bool
def equal_dimension?(x,y)
  (one_dimension?(x) && one_dimension?(y)) ||
    (two_dimensions?(x) && two_dimensions?(y))
end