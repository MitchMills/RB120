class MyCar
  attr_accessor :color
  attr_reader :year, :model

  def initialize(year, color, model)
    @year = year
    self.color = color
    @model = model
    @current_speed = 0
  end

  def accelerate(amount)
    @current_speed += amount
    puts "Accelerating by #{amount} miles per hour."
    current_speed
  end

  def decelerate(amount)
    @current_speed -= amount
    puts "Decelerating by #{amount} miles per hour."
    current_speed
  end

  def current_speed
    puts "Your current speed is now #{@current_speed} miles per hour."
  end

  def turn_off
    @current_speed = 0
    puts "You have turned off the car."
  end

  def spray_paint(color)
    former_color = self.color
    self.color = color
    puts "Your formerly #{former_color} car is now #{color}!"
  end

  def self.gas_mileage(miles_driven, gallons_used)
    mpg = miles_driven.fdiv(gallons_used).round(2)
    puts "Your gas mileage is #{mpg} miles per gallon."
  end

  def to_s
    "Your car is a #{year} #{color} #{model}."
  end
end

fred = MyCar.new(1997, 'red', 'prizm')
puts fred
