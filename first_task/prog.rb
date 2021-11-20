class Prog

  # поскольку этот метод вызывается из main, он  public

  def menu
    while true do
      puts "Введите номер команды"
      puts "1 Создать станцию"
      puts "2 Создать поезд"
      puts "3 Создать маршрут"
      puts "4 Перейти к управлению станцией"
      puts "5 Перейти к управлению поездом"
      puts "6 Перейти к управлению маршрутом"
      puts "7 Закончить работу"
    
      command = gets.chomp.to_i
    
      case command
      when 1
        create_station
      when 2
        create_train
      when 3
        create_route
      when 4
        control_station
      when 5
        control_train
      when 6
        control_route
      when 7
        break
      else
        puts "Неправильная команда"
      end
    end 
  end

  def initialize
    #@main_trains = []
    #@main_stations = []
    @main_routes = []
  end

  private

  # поскольку методы ниже вызываются только из метода menu или других методов этого класса, они  private

  #attr_accessor :main_trains, :main_stations, :main_routes
  attr_accessor :main_routes

  def create_station
    puts "Введите название станции"
    station_name = gets.chomp
    #station = main_stations.find { |st| st.name == station_name}
    station = Station.all.find { |st| st.name == station_name}
    if station.nil? 
      #main_stations.push(Station.new(station_name))
      Station.add_to_all(Station.new(station_name))
    else    
      puts "Такая станция уже существует"
    end
  end
  
  def create_train
    while true do
      puts "Введите номер поезда"
      train_number = gets.chomp
      train = Train.find(train_number)
      if train.nil? 
        puts "Выберите тип: 1-грузовой, 2-пассажирский"
        type = gets.chomp.to_i
        puts "Введите название компании"
        company_name = gets.chomp
        case type
        when 1
          begin
            Train.add_to_all(CargoTrain.new(train_number, company_name))
            puts "Поезд успешно создан"
            break
          rescue RuntimeError => e
            puts "Ошибка при вводе параметров:"
            puts e.message
            puts "Попробуйте ещё раз"
          end
        when 2
          begin
            Train.add_to_all(PassengerTrain.new(train_number, company_name))
            puts "Поезд успешно создан"
            break
          rescue RuntimeError => e
            puts "Ошибка при вводе параметров:"
            puts e.message
            puts "Попробуйте ещё раз"
          end
        else
          puts "Неправильный тип"
        end
      else    
        puts "Поезд с таким номером уже существует"
      end
    end
  end
  
  def create_route
    
    puts "Введите название начальной станции"
    first_station_name = gets.chomp
    #first_station = main_stations.find { |st| st.name == first_station_name}
    first_station = Station.all.find { |st| st.name == first_station_name}
  
    if first_station.nil? 
      puts "Такой станции нет"
      return
    end
  
    puts "Введите название конечной станции"
    last_station_name = gets.chomp
    #last_station = main_stations.find { |st| st.name == last_station_name}
    last_station = Station.all.find { |st| st.name == last_station_name}
  
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
    #station = main_stations.find { |st| st.name == station_name}
    station = Station.all.find { |st| st.name == station_name}
  
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
        station.each_train {|train| puts "Номер поезда: #{train.number} , тип поезда: #{train.type}, название компании: #{train.company_name}, скорость: #{train.speed} ,кол-во вагонов: #{train.numbers_car}"}
      when 2
        puts "Выберите тип: 1-грузовой, 2-пассажирский"
        type = gets.chomp.to_i
        case type
        when 1
          station.trains_by("Cargo").each {|train| puts "Номер поезда: #{train.number} , тип поезда: #{train.type}, название компании: #{train.company_name}, скорость: #{train.speed} ,кол-во вагонов: #{train.numbers_car}"}
        when 2
          station.trains_by("Passenger").each {|train| puts "Номер поезда: #{train.number} , тип поезда: #{train.type}, название компании: #{train.company_name}, скорость: #{train.speed} ,кол-во вагонов: #{train.numbers_car}"}
        else
          puts "Неправильный тип"
        end
      when 3
        watch_count_on_station(station)
      when 4
        break
      else
        puts "Неправильная команда"
      end
    end
  end
  
  def watch_count_on_station(station)
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
  end

  def control_train
    puts "Введите номер поезда"
    train_number = gets.chomp
    #train = main_trains.find { |tr| tr.number == train_number}
    train = Train.find(train_number)

    if train.nil? 
      puts "Такого поезда нет"
      return
    end
  
    while true do
      puts "Поезд на станции: #{train.current_station.name}" unless train.current_station.nil?
      puts "Введите номер команды"
      puts "1 Назачить маршрут"
      puts "2 Добавить вагоны"
      puts "3 Удалить вагоны"
      puts "4 Проехать вперед"
      puts "5 Проехать назад"
      puts "6 Вывести список вагонов"
      puts "7 Занять место в вагоне" if train.type == "Passenger"
      puts "7 Занять объем в вагоне" if train.type == "Cargo"
      puts "8 Выход"
  
      command = gets.chomp.to_i
  
      case command
      when 1
        assign_route(train)
      when 2
        add_car(train)
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
        train.each_car{|car| puts "Название компании : #{car.company_name}, кол-во свободных мест : #{car.free_capacity}, кол-во занятых мест : #{car.occupied_capacity}"} if train.type == "Passenger"
        train.each_car{|car| puts "Название компании : #{car.company_name}, свободный объем : #{car.free_capacity}, занятый объем : #{car.occupied_capacity}"} if train.type == "Cargo"
      when 7
        puts "Введите номер вагона"
        car_index = gets.chomp.to_i
        if car_index > train.cars.size || car_index < 1
          puts "Такого вагона нет"
        else
          puts "Введите объём" if train.type == "Cargo"
          capacity = gets.chomp.to_i if train.type == "Cargo"
          train.cars[car_index - 1].take_the_place if train.type == "Passenger"
          train.cars[car_index - 1].take_capacity(capacity) if train.type == "Cargo"
        end
      when 8
        break
      else
        puts "Неправильная команда"
      end
    end
  end

  def add_car(train)
    puts "Введите количество вагонов"
    count = gets.chomp.to_i       
    while count != 0 do
      puts "Введите название компании"
      company_name = gets.chomp 
      puts "Введите кол-во мест в вагоне" if train.type == "Passenger"
      puts "Введите общий объём вагона" if train.type == "Cargo"
      capacity = gets.chomp.to_i
      car = CargoCar.new(company_name, capacity) if train.type == "Cargo"
      car = PassengerCar.new(company_name, capacity) if train.type == "Passenger"
      train.hook_up_car(car)
      count -= 1
    end
  end

  def assign_route(train)
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
        add_station(route) 
      when 3
        delete_station(route)
      when 4
        break
      else
        puts "Неправильная команда"
      end
    end
  end

  def add_station(route)
    puts "Введите название станции"
    station_name = gets.chomp
    #station = main_stations.find { |st| st.name == station_name}
    station = Station.all.find { |st| st.name == station_name}
    if station.nil? 
      puts "Такой станции нет"
      return
    end
    puts "Введите позицию на которую хотите добавить станцию"
    position = gets.chomp.to_i - 1
    route.add_station(station, position)
  end

  def delete_station(route)
    puts "Введите название станции"
    station_name = gets.chomp
    #station = route.stations.find { |st| st.name == station_name}
    station = Station.all.find { |st| st.name == station_name}
    if station.nil? 
      puts "Такой станции в маршруте нет"
      return
    end
    route.delete_station(station)
    puts "Станция удалена"
  end
end

