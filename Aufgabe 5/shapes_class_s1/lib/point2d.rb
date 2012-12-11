#Point2d ::= Point1d x Point1d
def_class(:Point2d,[:x,:y]){
  def invariant?
    (x.int? && y.int?)
  end
}
