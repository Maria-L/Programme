class Object
  def range1d?; false end
  
  def range2d?; false end
  
  def union1d?; false end
  
  def union2d?; false end
  
  def point2d?; false end
  
  def shape1d?; false end
  
  def shape2d?; false end
  
  def shape?; false end
  
  def point?; false end
  
  def primshape?; false end
  
  def compshape?; false end
  
  def unionshape?; false end
  
  def graphobj?; false end
  
  def one_dimension?; false end
  
  def two_dimensions?; false end
    
  #equal_dimension? ::= (x,y) :: Any x Any -> Bool
  def equal_dimension?(y)
    (self.one_dimension? && y.one_dimension?) ||
      (self.two_dimensions? && y.two_dimensions?)
  end
end