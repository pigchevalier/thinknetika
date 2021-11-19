require_relative 'instance_counter'

class Station

  include InstanceCounter

  # методы вызываются в классе Prog (отвечает за меню) и не только в нем, следовательно public

  attr_reader :name, :trains


  @@all_stations = []

  def initialize(name)
    @name = name
    @trains = []
    register_instance
  end

  def self.all
    @@all_stations
  end

  def self.add_to_all(station)
    @@all_stations.push(station)
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
