require_relative 'instance_counter'

class Route

  include InstanceCounter
  
  # все методы вызываются в классе Prog (отвечает за меню), следовательно public

  attr_reader :stations
  
  self.count_elements = 0

  
  def initialize (first_station, last_station)
    @stations = []
    @stations << first_station
    @stations << last_station
    register_instance
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



end