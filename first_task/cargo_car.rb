require_relative 'car'

class CargoCar < Car

  def take_capacity(volume)
    if free_capacity <= volume
      @free_capacity = 0
    else
      @free_capacity -= volume
    end
  end

  private

  # private тк используется только в этом классе

  def type_car
    "Cargo"
  end

end