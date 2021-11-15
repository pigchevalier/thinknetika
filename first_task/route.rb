class Route

  attr_reader :stations
  
  def initialize (first_station, last_station)
    @stations = []
    @stations<<first_station
    @stations<<last_station
  end

  def add_station(position = stations.size-1, station)
    stations.insert(position, station) if position<stations.size && position>0
  end

  def delete_station(station)
    stations.delete(station) if station != stations[0] && station != stations[stations.size-1]
  end

  def all_stations
    stations.each { |station| puts station.name}  
  end



end