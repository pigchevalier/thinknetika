class Car
  
  #возможно где-то захочется узнать тип, поэтому он public

  attr_reader :type
  
  def initialize 
    @type = type_car
  end

  protected 

  # данный метод используется только внутри класса, но поскольку он должен быть переопределен в классах-потомках он protected

  def type_car
    "nothing"
  end

end