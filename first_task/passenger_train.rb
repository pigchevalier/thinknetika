require_relative 'train'
require_relative 'passenger_car'

class PassengerTrain < Train

  # в базовом классе у этого метода public значит и тут так должно быть

  def hook_up_car
    if speed == 0
      car = PassengerCar.new
      cars.push(car)
    end
  end

  protected

  # в базовом классе у этого метода protected значит и тут так должно быть

  def type_train
    "Passenger"
  end

end