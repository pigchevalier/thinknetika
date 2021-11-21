require_relative 'company.rb'

class Car

  include Company

  attr_reader :type, :capacity, :free_capacity

  NAME_FORMAT = /^[A-ZА-Я].*/

  def initialize(company_name, capacity)
    @type = type_car 
    @capacity = capacity
    @free_capacity = capacity
    self.company_name = company_name
    validate!
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  def occupied_capacity
    capacity - free_capacity
  end

  private

  def validate!
    raise "Company name can't be nil" if company_name.nil?
    raise "Company name should be at least 3 symbols" if company_name.length < 3
    raise "Company name has invalid format" if company_name !~ NAME_FORMAT 
    raise "Car type can't be nil" if type.nil?
  end


end