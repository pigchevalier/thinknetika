require_relative 'train'
require_relative 'cargo_car'

class CargoTrain < Train

  # в базовом классе у этого метода public значит и тут так должно быть

  def hook_up_car
    if speed == 0
      car = CargoCar.new
      cars.push(car)
    end
  end

  protected

  # в базовом классе у этого метода protected значит и тут так должно быть

  def type_train
    "Cargo"
  end


end