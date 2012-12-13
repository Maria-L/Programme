class GraphObj
 
  ####CREATION#####
  def self.[](*args)
    check_inv(self.new(*args))
  end
  
  def invariant?; abstract end
  
  def graphobj?; true end
end