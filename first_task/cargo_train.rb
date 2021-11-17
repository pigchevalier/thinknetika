require_relative 'train'
require_relative 'cargo_car'

class CargoTrain < Train


  protected

  # в базовом классе у этого метода protected значит и тут так должно быть

  def type_train
    "Cargo"
  end


end