class Point < GraphObj
  
  ####METHODS####
  def to_s
    "#{self.class.name} [#{x}, #{y}]"
  end
  ####PRAEDICATS####
  def point?; true end
end
