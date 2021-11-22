module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_accessor :massive

    def presence(var,params)
      raise RuntimeError.new "can't be nil" if var.nil?
      raise RuntimeError.new "can't be empty" if var == ""
    end

    def format(var,params)
      raise RuntimeError.new "has invalid format" if var !~ params
    end

    def type(var,params)
      raise RuntimeError.new "has wrong type" if var.class != params
    end

    def validate( name, type_of_validate, option = nil)     
      self.massive.push({name: name.to_s, validation_type: type_of_validate.to_s, params: option})
    end
  end

  module InstanceMethods
    def validate!
      self.class.massive.each do |mass| 
        var_name = "@#{mass[:name]}"
        var = instance_variable_get(var_name)
        begin
          self.class.send mass[:validation_type] , var, mass[:params]
        rescue RuntimeError => e
          puts "#{var_name} #{e.message}"
          raise e
        end
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