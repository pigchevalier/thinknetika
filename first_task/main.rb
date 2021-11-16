require_relative 'route'
require_relative 'train'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'car'
require_relative 'passenger_car'
require_relative 'cargo_car'
require_relative 'station'
require_relative 'prog'


program = Prog.new()

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
    program.create_station
  when 2
    program.create_train
  when 3
    program.create_route
  when 4
    program.control_station
  when 5
    program.control_train
  when 6
    program.control_route
  when 7
    break
  else
    puts "Неправильная команда"
  end
end
