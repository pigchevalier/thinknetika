require_relative 'train'
require_relative 'passenger_car'

class PassengerTrain < Train


  protected

  # в базовом классе у этого метода protected значит и тут так должно быть

  def type_train
    "Passenger"
  end

end