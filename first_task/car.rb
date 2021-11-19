require_relative 'company.rb'

class Car

  include Company

  attr_reader :type

  NAME_FORMAT = /^[A-ZА-Я].*/

  def initialize(company_name)
    @type = type_car 
    self.company_name = company_name
    validate!
  end

  def valid?
    validate!
    true
  rescue
    false
  end

  private

  def validate!
    raise "Company name can't be nil" if company_name.nil?
    raise "Company name should be at least 3 symbols" if company_name.length < 3
    raise "Company name has invalid format" if company_name !~ NAME_FORMAT 
    raise "Car type can't be nil" if type.nil?
  end


end