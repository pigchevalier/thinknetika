require_relative 'car'

class PassengerCar < Car

  def take_the_place
    if free_capacity > 0
      @free_capacity -= 1
    end
  end


  private

  # private тк используется только в этом классе

  def type_car
    "Passenger"
  end

end