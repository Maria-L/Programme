class Shape < GraphObj

  ####PRAEDICATS####
  def shape?; true end

  ####METHODS####
  def graph_equal_trans?(o)
    o.graphobj? &&
      self.translate(self.lower_left).graph_equal?(o.translate(o.lower_left))
  end

  
  def translate(point); abstract end
  def bounds; abstract end
  def bounding_range(range); abstract end
  def in?(point); abstract end
  def graph_equal?(other); abstract end
  def lower_left; abstract end
  def to_s; abstract end
  
  def ==(other)
    self.graph_equal?(other)
  end
  
  
  
  #alias_method :==, :graph_equal?
end