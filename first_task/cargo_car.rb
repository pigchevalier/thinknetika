require_relative 'car'

class CargoCar < Car

  protected

  # в базовом классе этот метод protected, следовательно и тут он тоже должен быть protected

  def type_car
    "Cargo"
  end

end