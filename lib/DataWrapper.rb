class DataWrapper
  
  def initialize()
    @data = Array.new();
    @accessCount = 0;
  end
  
  attr_reader :accessCount
  attr_accessor :data
   
  def [](index)
    @accessCount += 1
    return @data[index]
  end
  
  def []=(index, value)
    @accessCount += 1
    @data[index] = value
  end
  
end