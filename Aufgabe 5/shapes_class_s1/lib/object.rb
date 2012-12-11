class Object
  #shape1d? ::= (x) :: Any -> Bool
  def shape1d?
    self.range1d? || self.union1d?
  end

  #shape2d? ::= (x) :: Any -> Bool
  def shape2d?
    self.range2d? || self.union2d?
  end

  #point? ::= (x) :: Any -> Bool
  def point?
    self.point2d?
  end
  
  #shape? ::= (x) :: Any -> Bool
  def shape?
    self.primshape? || self.compshape?
  end

  #primshape ::= (x) :: Any -> Bool
  def primshape?
    self.range1d? || self.range2d?
  end

  #compshape ::= (x) :: Any -> Bool
  def compshape?
    self.unionshape?
  end

  #unionshape ::= (x) :: Any -> Bool
  def unionshape?
    self.union1d? || self.union2d?
  end

  #graphobj ::= (x) :: Any -> Bool
  def graphobj?
    self.point? || self.shape?
  end

  #one_dimension? ::= (x) :: Any -> Bool
  def one_dimension?
    self.shape1d? || self.range1d? || self.int? || self.union1d?
  end

  #two_dimensions? ::= (x) :: Any -> Bool
  def two_dimensions?
    self.shape2d? || self.range2d? || self.point2d? ||  self.union2d?
  end

  #equal_dimension? ::= (x,y) :: Any x Any -> Bool
  def equal_dimension?(y)
    (self.one_dimension? && y.one_dimension?) ||
      (self.two_dimensions? && y.two_dimensions?)
  end
end


class Integer

  #point? ::= (x) :: Any -> Bool
  def point?
    true
  end

end