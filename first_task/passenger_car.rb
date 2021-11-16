require_relative 'car'

class PassengerCar < Car

  protected

  # в базовом классе этот метод protected, следовательно и тут он тоже должен быть protected

  def type_car
    "Passenger"
  end

end