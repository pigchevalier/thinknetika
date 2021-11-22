require_relative 'car'
require_relative 'company.rb'
require_relative 'instance_counter'
require_relative 'validation.rb'
require_relative 'accessor.rb'

class Train

  include Company
  include InstanceCounter
  include Validation
  include Accessor


  # все методы ниже (до private) вызываются в других классах (например в Prog отвечающего за меню), поэтому public

  #attr_reader :speed, :type, :cars, :number
  strong_attr_accessor :type , String
  attr_accessor_with_history :speed, :number, :cars

  NAME_FORMAT = /^[A-ZА-Я].{2,}/
  NUMBER_FORMAT = /^[a-zа-я0-9]{3}-?[a-zа-я0-9]{2}$/i

  @@all_trains = []

  def initialize(number, company_name)
    self.number = number
    self.type = type_train
    self.company_name = company_name
    self.speed = 0
    self.cars = []
    my_validate
    validate!
    register_instance  
  end

  def my_validate
    self.class.massive =[]
    self.class.validate :number, :presence
    self.class.validate :number, :format, NUMBER_FORMAT
    self.class.validate :number, :type, String
    self.class.validate :company_name, :presence
    self.class.validate :company_name, :format, NAME_FORMAT
    self.class.validate :company_name, :type, String
  end

  def each_car (&block)
    cars.each{|car| block.call(car)}
  end

  def self.add_to_all(train)
    @@all_trains.push(train)
  end

  def self.find(number)
    @@all_trains.find { |tr| tr.number == number}
  end
  

  def hook_up_car(car)
    return if car.type != type
    if speed == 0
      cars.push(car)
    end
  end

  def unhook_car
    if speed == 0 && numbers_car > 0
      cars.pop
    end
  end

  def numbers_car
    cars.size
  end

  def assign_route(route)
    @route = route
    @index_current_station = 0
    current_station.send_train(self)
    current_station.take_train(self)
  end

  def forward
    return unless next_station
    @index_current_station += 1
    previous_station.send_train(self)
    current_station.take_train(self)
    
  end

  def back
    return unless previous_station
    @index_current_station -= 1 
    next_station.send_train(self)
    current_station.take_train(self)
  end

  def current_station
    @route.stations[@index_current_station] unless @route.nil?
  end

  private

  # на данный момент все методы ниже вызываются только из класса поэтому private

  def next_station
    @route.stations[@index_current_station + 1] if @index_current_station < @route.stations.size
  end

  def previous_station
    @route.stations[@index_current_station - 1] if @index_current_station > 0
  end

  def stop
    self.speed = 0
  end

  def add_speed(speed)
    self.speed += speed
  end

  private

  #def validate!
  #  validate_number!
  #  validate_type!
  #  validate_company_name!  
  #end
#
  #def validate_number!
  #  raise "Train number has invalid format" if number !~ NUMBER_FORMAT
  #end
#
  #def validate_type!
  #  raise "Train type can't be nil" if type.nil? 
  #end
#
  #def validate_company_name!
  #  raise "Company name can't be nil" if company_name.nil?
  #  raise "Company name should be at least 3 symbols" if company_name.length < 3
  #  raise "Company name has invalid format" if company_name !~ NAME_FORMAT 
  #end
end