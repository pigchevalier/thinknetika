require_relative 'car'

class CargoCar < Car

  private

  # private тк используется только в этом классе

  def type_car
    "Cargo"
  end

end