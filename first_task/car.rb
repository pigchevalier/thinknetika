require_relative 'company.rb'
require_relative 'validation.rb'
require_relative 'accessor.rb'

class Car

  include Company
  include Validation
  include Accessor

  #attr_reader :type, :capacity, :free_capacity
  strong_attr_accessor :type , String
  attr_accessor_with_history :capacity, :free_capacity

  NAME_FORMAT = /^[A-ZА-Я].{2,}/

  def initialize(company_name, capacity)
    self.type = type_car 
    self.capacity = capacity
    self.free_capacity = capacity
    self.company_name = company_name
    my_validate
    validate!
  end

  def my_validate
    self.class.massive =[]
    self.class.validate :company_name, :presence
    self.class.validate :company_name, :format, NAME_FORMAT
    self.class.validate :company_name, :type, String
  end

  def occupied_capacity
    capacity - free_capacity
  end

  private

  #def validate!
  #  raise "Company name can't be nil" if company_name.nil?
  #  raise "Company name should be at least 3 symbols" if company_name.length < 3
  #  raise "Company name has invalid format" if company_name !~ NAME_FORMAT 
  #  raise "Car type can't be nil" if type.nil?
  #end


end