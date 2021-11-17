class Car
  
attr_reader :type

def initialize
  @type = type_car 
end

protected

# protected чтобы перегрузить в наследниках

def type_car

end

end