
#Range1d ::= Int x Int
def_class(:Range1d,[:first,:last]){
  def invariant?
    (first.int? && last.int?)
  end
}

#Union1d ::= Shape1d x Shape1d
def_class(:Union1d,[:left,:right]){
  def invariant?
    (left.union1d? || left.range1d?) && (right.union1d? || right.range1d?)
  end
}

#Point2d ::= Point1d x Point1d
def_class(:Point2d,[:x,:y]){
  def invariant?
    (x.int? && y.int?)
  end
}

#Range2d ::= Range1d x Range1d
def_class(:Range2d,[:x_range,:y_range]){
  def invariant?
    (x_range.range1d? && y_range.range1d?)
  end
}

#Union2d ::= Shape2d x Shape2d
def_class(:Union2d,[:left,:right]){
  def invariant?
    shape2d?(left) && shape2d?(right)
  end
}

#class Object
# def shape2d?; range2d? or union2d? end
#end