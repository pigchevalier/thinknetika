module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(obj, name, type_of_validate, option = nil)
      var_name = "@#{name}"
      if type_of_validate == :presence
        raise "#{name} can't be nil" if obj.instance_variable_get(var_name).nil?
        raise "#{name} can't be empty" if obj.instance_variable_get(var_name) == ""
      elsif type_of_validate == :format
        raise "#{name} has invalid format" if obj.instance_variable_get(var_name) !~ option
      elsif type_of_validate == :type
        raise "Wrong type of #{name}" if obj.instance_variable_get(var_name).class != option
      end
    end
  end

  module InstanceMethods
    def validate!
      if self.class == Car || self.class == CargoCar || self.class == PassengerCar
        self.class.validate self, :company_name, :presence
        self.class.validate self, :company_name, :format, self.class.const_get("NAME_FORMAT")
        self.class.validate self, :company_name, :type, String
      elsif self.class == Train || self.class == CargoTrain || self.class == PassengerTrain
        self.class.validate self, :number, :presence
        self.class.validate self, :number, :format, self.class.const_get("NUMBER_FORMAT")
        self.class.validate self, :number, :type, String
        self.class.validate self, :company_name, :presence
        self.class.validate self, :company_name, :format, self.class.const_get("NAME_FORMAT")
        self.class.validate self, :company_name, :type, String
      elsif self.class == Station
        self.class.validate self, :name, :presence
        self.class.validate self, :name, :format, self.class.const_get("NAME_FORMAT")
        self.class.validate self, :name, :type, String
      elsif self.class == Route
        self.class.validate self, :first_station, :presence
        self.class.validate self, :last_station, :presence
        self.class.validate self, :first_station, :type, Station
        self.class.validate self, :last_station, :type, Station
      end
    end

    def valid?
      validate!
      true
    rescue
      false
    end
  end
end