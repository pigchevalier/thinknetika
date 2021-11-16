class Prog

  # поскольку все методы вызываются из main, они все public

  

  def initialize
    @main_trains = []
    @main_stations = []
    @main_routes = []
  end



  def create_station
    puts "Введите название станции"
    station_name = gets.chomp
    station = main_stations.find { |st| st.name == station_name}
    if station.nil? 
      main_stations.push(Station.new(station_name))
    else    
      puts "Такая станция уже существует"
    end
  end
  
  
  
  
  
  def create_train
    puts "Введите номер поезда"
    train_number = gets.chomp
    train = main_trains.find { |tr| tr.number == train_number}
    if train.nil? 
      puts "Выберите тип: 1-грузовой, 2-пассажирский"
        type = gets.chomp.to_i
        case type
        when 1
          main_trains.push(CargoTrain.new(train_number))
        when 2
          main_trains.push(PassengerTrain.new(train_number))
        else
          puts "Неправильный тип"
        end
    else    
      puts "Поезд с таким номером уже существует"
    end
  end
  
  
  
  
  
  def create_route
    
    puts "Введите название начальной станции"
    first_station_name = gets.chomp
    first_station = main_stations.find { |st| st.name == first_station_name}
  
    if first_station.nil? 
      puts "Такой станции нет"
      return
    end
  
    puts "Введите название конечной станции"
    last_station_name = gets.chomp
    last_station = main_stations.find { |st| st.name == last_station_name}
  
    if last_station.nil? 
      puts "Такой станции нет"
      return
    end
  
    main_routes.push(Route.new(first_station,last_station))
    puts "Маршрут создан"
  
  end
  
  
  
  
  
  def control_station
    puts "Введите название станции"
    station_name = gets.chomp
    station = main_stations.find { |st| st.name == station_name}
  
    if station.nil? 
      puts "Такой станции нет"
      return
    end
  
    while true do
      puts "Введите номер команды"
      puts "1 Посмотреть список поездов на станции"
      puts "2 Посмотреть список поездов определенного типа на станции"
      puts "3 Посмотреть количество поездов определенного типа на станции"
      puts "4 Выход"
  
      command = gets.chomp.to_i
  
      case command
      when 1
        station.trains.each {|train| puts "Номер позда: #{train.number} , тип поезда: #{train.type}, скорость: #{train.speed} ,кол-во вагонов: #{train.numbers_car}"}
      when 2
        puts "Выберите тип: 1-грузовой, 2-пассажирский"
        type = gets.chomp.to_i
        case type
        when 1
          station.trains_by("Cargo").each {|train| puts "Номер позда: #{train.number} , тип поезда: #{train.type}, скорость: #{train.speed} ,кол-во вагонов: #{train.numbers_car}"}
        when 2
          station.trains_by("Passenger").each {|train| puts "Номер позда: #{train.number} , тип поезда: #{train.type}, скорость: #{train.speed} ,кол-во вагонов: #{train.numbers_car}"}
        else
          puts "Неправильный тип"
        end
      when 3
        puts "Выберите тип: 1-грузовой, 2-пассажирский"
        type = gets.chomp.to_i
        case type
        when 1
          puts "Количество: #{station.count_trains_by("Cargo")}"
        when 2
          puts "Количество: #{station.count_trains_by("Passenger")}"
        else
          puts "Неправильная команда"
        end
      when 4
        break
      else
        puts "Неправильная команда"
      end
    end
  end
  
  
  
  
  
  def control_train
    puts "Введите номер поезда"
    train_number = gets.chomp
    train = main_trains.find { |tr| tr.number == train_number}
  
    if train.nil? 
      puts "Такого поезда нет"
      return
    end
  
    while true do
      puts "Пеозд на станции: #{train.current_station.name}" unless train.current_station.nil?
      puts "Введите номер команды"
      puts "1 Назачить маршрут"
      puts "2 Добавить вагоны"
      puts "3 Удалить вагоны"
      puts "4 Проехать вперед"
      puts "5 Проехать назад"
      puts "6 Выход"
  
      command = gets.chomp.to_i
  
      case command
      when 1
        i = 1
        main_routes.each do |route| 
          puts "Маршрут №#{i}"
          i += 1 
          route.all_stations
        end
        puts "Введите номер маршрута"
  
        route_index = gets.chomp.to_i - 1
  
        if route_index <= main_routes.size && route_index >= 0
          route = main_routes[route_index]
          train.assign_route(route)
          puts "Маршрут назначен"
        else
          puts "Такого маршрута нет"
        end
  
      when 2
        puts "Введите количество вагонов"
        count = gets.chomp.to_i
        while count != 0 do
          train.hook_up_car
          count -= 1
        end
      when 3
        puts "Введите количество вагонов"
        count = gets.chomp.to_i
        while count != 0 do
          train.unhook_car
          count -= 1
        end
      when 4
        train.forward        
      when 5
        train.back
      when 6
        break
      else
        puts "Неправильная команда"
      end
    end
  end
  
  
  
  
  
  def control_route
  
    i = 1
    main_routes.each do |route| 
      puts "Маршрут №#{i}"
      i += 1 
      route.all_stations
    end
  
    puts "Введите номер маршрута"
  
    route_index = gets.chomp.to_i - 1
  
    if route_index <= main_routes.size && route_index >= 0
      route = main_routes[route_index]
    else
      puts "Такого маршрута нет"
      return
    end
  
    while true do
      puts "Введите номер команды"
      puts "1 Посмотреть список станций"
      puts "2 Добавить станцию"
      puts "3 Удалить станцию"
      puts "4 Выход"
  
      command = gets.chomp.to_i
  
      case command
      when 1
        route.all_stations
      when 2
        puts "Введите название станции"
        station_name = gets.chomp
        station = main_stations.find { |st| st.name == station_name}
  
        if station.nil? 
          puts "Такой станции нет"
          return
        end
  
        puts "Введите позицию на которую хотите добавить станцию"
        position = gets.chomp.to_i - 1
  
        route.add_station(station, position)
  
      when 3
        puts "Введите название станции"
        station_name = gets.chomp
        station = route.stations.find { |st| st.name == station_name}
  
        if station.nil? 
          puts "Такой станции в маршруте нет"
          return
        end
  
        route.delete_station(station)
        puts "Станция удалена"
      when 4
        break
      else
        puts "Неправильная команда"
      end
    end
  end


  # все атрибуты используются только в этом классе, поэтому они все private
  private 

  attr_accessor :main_trains, :main_stations, :main_routes

end
