require_relative 'instance_counter'

class Station

  include InstanceCounter

  # методы вызываются в классе Prog (отвечает за меню) и не только в нем, следовательно public

  attr_reader :name, :trains

  NAME_FORMAT = /^[A-ZА-Я].*/

  @@all_stations = []

  def initialize(name)
    @name = name
    @trains = []
    validate!
    register_instance
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def each_train (&block)
    trains.each{|train| block.call(train)}
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


  private

  def validate!
    raise "Station name can't be nil" if name.nil?
    raise "Station name should be at least 3 symbols" if name.length < 3
    raise "Station name has invalid format" if name !~ NAME_FORMAT 
  end
  

end
