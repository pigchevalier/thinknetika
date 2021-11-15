class Train


  attr_reader :numbers_car, :speed, :type


  def initialize(number, type, numbers_car)
    @number = number
    @type = type
    @numbers_car = numbers_car
    @speed = 0

  end

  def stop
    @speed = 0
  end

  def add_speed(speed)
    @speed+=speed
  end

  def hook_up_car
    @numbers_car+=1 if speed == 0
  end

  def unhook_car
    @numbers_car-=1 if speed == 0 && numbers_car > 0
  end

  def assign_route(route)
    @route = route
    @index_current_station = 0
    current_station.take_train(self)
  end

  def forward
    if @index_current_station<@route.stations.size
      @index_current_station+=1
      previous_station.send_train(self)
      current_station.take_train(self)
    end
  end

  def back
    if @index_current_station>0
      @index_current_station-=1 
      next_station.send_train(self)
      current_station.take_train(self)
    end
  end

  def next_station
    @route.stations[@index_current_station+1] if @index_current_station<@route.stations.size
  end

  def previous_station
    @route.stations[@index_current_station-1] if @index_current_station>0
  end

  def current_station
    @route.stations[@index_current_station]
  end
end