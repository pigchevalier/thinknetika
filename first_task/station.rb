class Station

  # методы вызываются в классе Prog (отвечает за меню) и не только в нем, следовательно public

  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  # вызывается в классе Train, следовательно public

  def take_train(train)
    @trains << train
  end

  # вызывается в классе Train, следовательно public

  def send_train(train)
    @trains.delete(train)
  end 

  # все методы ниже вызываются в классе Prog (отвечает за меню), следовательно public

  def trains_by(type)
    trains.find_all { |train| train.type == type}  
  end

  def count_trains_by(type)
    trains = trains_by(type)
    trains.size
  end

  

end
