require_relative 'car'

class CargoCar < Car

protected

# protected в базовом классе, значит и тут тоже

def type_car
  "Cargo"
end

end