class Station

  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def take_train(train)
    @trains << train
  end


  def type_trains
    freight_trains = trains.find_all { |train| train.type == "freight"} 
    passenger_trains = trains.find_all { |train| train.type == "passenger"} 
    puts @freight_size = freight_trains.size
    puts @passenger_size = passenger_trains.size
  end

  def send_train(train)
    @trains.delete(train)
  end 

end
