require_relative 'instance_counter'
require_relative 'validation.rb'
require_relative 'accessor.rb'
require_relative 'station.rb'

class Route

  include InstanceCounter
  include Validation
  include Accessor
  
  # все методы вызываются в классе Prog (отвечает за меню), следовательно public

  #attr_reader :stations :first_station, :last_station
  strong_attr_accessor :first_station, Station
  strong_attr_accessor :last_station, Station
  attr_accessor_with_history :stations
  
  def initialize (first_station, last_station)
    self.stations = []
    self.stations << first_station
    self.stations << last_station
    self.first_station = first_station
    self.last_station = last_station
    my_validate
    validate!
    register_instance
  end

  def my_validate
    self.class.valid_array = []
    self.class.validate :first_station, :presence
    self.class.validate :last_station, :presence
    self.class.validate :first_station, :type, String
    self.class.validate :last_station, :type, String
  end

  def add_station(station, position = stations.size - 1)
    stations.insert(position, station) if position < stations.size && position > 0
  end

  def delete_station(station)
    stations.delete(station) if station != stations[0] && station != stations[stations.size - 1]
  end

  def all_stations
    stations.each { |station| puts station.name}  
  end

  private

  #def validate!
  #  raise "First station can't be nil" if stations[0].nil?
  #  raise "Last station can't be nil" if stations[stations.size - 1].nil?
  #end



end