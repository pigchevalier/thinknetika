module InstanceCounter
  

  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    
    
    def instances
      count_elements ||= 0
      count_elements
    end

    def count_elements
      @count_elements
    end
    def count_elements= var
      @count_elements = var
    end
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.count_elements ||= 0     
      self.class.count_elements += 1
    end
  end
end