class Vehicle
  WHEELS = 4
end

WHEELS = 6

class Car < Vehicle
  def wheels
    WHEELS
  end
end

car = Car.new
puts car.wheels        # => 4
