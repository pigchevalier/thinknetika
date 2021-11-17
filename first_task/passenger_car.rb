require_relative 'car'

class PassengerCar < Car



protected

# protected в базовом классе, значит и тут тоже

def type_car
  "Passenger"
end

end