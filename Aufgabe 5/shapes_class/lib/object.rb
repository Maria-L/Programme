class Object
  
  def range1d?; false end
  
  #shape1d? ::= (x) :: Any -> Bool
  def shape1d?; false end

  #shape2d? ::= (x) :: Any -> Bool
  def shape2d?; false end

  #point? ::= (x) :: Any -> Bool
  def point?; false end
  
  #shape? ::= (x) :: Any -> Bool
  def shape?; false end

  #primshape ::= (x) :: Any -> Bool
  def primshape?; false end

  #compshape ::= (x) :: Any -> Bool
  def compshape?; false end

  #unionshape ::= (x) :: Any -> Bool
  def unionshape?; false end

  #graphobj ::= (x) :: Any -> Bool
  def graphobj?; false end

  #one_dimension? ::= (x) :: Any -> Bool
  def one_dimension?; false end

  #two_dimensions? ::= (x) :: Any -> Bool
  def two_dimensions?; false end

  #equal_dimension? ::= (x,y) :: Any x Any -> Bool
  def equal_dimension?(y)
    (self.one_dimension? && y.one_dimension?) ||
      (self.two_dimensions? && y.two_dimensions?)
  end
end


class Integer
  #point? ::= (x) :: Any -> Bool
  def point?; true end
end