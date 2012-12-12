class GraphObj
 
  def self.[](*args)
    check_inv(self.new(*args))
  end
  
  def graphobj?; true end
end