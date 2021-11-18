require_relative 'company.rb'

class Car

  include Company

  attr_reader :type

  def initialize(company_name)
    @type = type_car 
    self.company_name = company_name
  end
end