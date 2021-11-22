require_relative 'instance_counter'
require_relative 'validation.rb'
require_relative 'accessor.rb'

class Station

  include InstanceCounter
  include Validation
  include Accessor

  # методы вызываются в классе Prog (отвечает за меню) и не только в нем, следовательно public

  #attr_reader :name, :trains
  strong_attr_accessor :name, String
  attr_accessor_with_history :trains

  NAME_FORMAT = /^[A-ZА-Я].{2,}/

  @@all_stations = []

  def initialize(name)
    self.name = name
    self.trains = []
    my_validate
    validate!
    register_instance
  end

  def my_validate
    self.class.valid_array = []
    self.class.validate :name, :presence
    self.class.validate :name, :format, NAME_FORMAT
    self.class.validate :name, :type, String
  end

  def each_train (&block)
    #trains.each{|train| block.call(train)}
    trains.each{|train| yield(train)}
  end

  def self.all
    @@all_stations
  end

  def self.add_to_all(station)
    @@all_stations.push(station)
  end

  # вызывается в классе Train, следовательно public

  def take_train(train)
    self.trains << train
  end

  # вызывается в классе Train, следовательно public

  def send_train(train)
    self.trains.delete(train)
  end 

  # все методы ниже вызываются в классе Prog (отвечает за меню), следовательно public

  def trains_by(type)
    trains.find_all { |train| train.type == type}  
  end

  def count_trains_by(type)
    type_trains = trains_by(type)
    type_trains.size
  end


  private

  #def validate!
  #  raise "Station name can't be nil" if name.nil?
  #  raise "Station name should be at least 3 symbols" if name.length < 3
  #  raise "Station name has invalid format" if name !~ NAME_FORMAT 
  #end
  

end
