class Station

  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def take_train(train)
    @trains << train
  end


  def trains_by(type)
    trains.find_all { |train| train.type == type}  
  end

  def count_trains_by(type)
    trains = trains_by(type)
    trains.size
  end

  def send_train(train)
    @trains.delete(train)
  end 

end
