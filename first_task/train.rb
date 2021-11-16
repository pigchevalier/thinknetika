require_relative 'car'

class Train


  # все методы ниже (до private) вызываются в других классах (например в Prog отвечающего за меню), поэтому public

  attr_reader :speed, :type, :cars, :number


  def initialize(number)
    @number = number
    @type = type_train
    @speed = 0
    @cars = []

  end


  

  def hook_up_car
    if speed == 0
      car = Car.new
      cars.push(car)
    end
  end

  def unhook_car
    if speed == 0 && numbers_car > 0
      cars.pop
    end
  end

  def numbers_car
    cars.size
  end

  def assign_route(route)
    @route = route
    @index_current_station = 0
    current_station.take_train(self)
  end

  def forward
    return unless next_station
    @index_current_station += 1
    previous_station.send_train(self)
    current_station.take_train(self)
    
  end

  def back
    return unless previous_station
    @index_current_station -= 1 
    next_station.send_train(self)
    current_station.take_train(self)
  end

  def current_station
    @route.stations[@index_current_station] unless @route.nil?
  end

  private

  # на данный момент все методы ниже вызываются только из класса поэтому private

  def next_station
    @route.stations[@index_current_station + 1] if @index_current_station < @route.stations.size
  end

  def previous_station
    @route.stations[@index_current_station - 1] if @index_current_station > 0
  end

  def stop
    @speed = 0
  end

  def add_speed(speed)
    @speed += speed
  end

  protected

  # этот метод вызывается только из класса, но должен быть переопределен в потомках, поэтому protected

  def type_train
    "nothing"
  end

end