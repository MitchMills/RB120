class MyCar
  attr_accessor :color
  attr_reader :year

  def initialize(year, color, model)
    @current_speed = 0
    @year = year
    @color = color
    @model = model
  end

  def accelerate(amount)
    @current_speed += amount
    puts "Accelerating by #{amount} miles per hour!"
  end

  def decelerate(amount)
    @current_speed -= amount
    puts "Slowing down by #{amount} miles per hour."
  end

  def turn_off
    @current_speed = 0
    puts "The car is now off"
  end

  def current_speed
    puts "Current speed is #{@current_speed}."
  end

  def spray_paint(color)
    self.color = color
  end
end

fred = MyCar.new(1997, 'blue', 'impala')
p fred
p fred.color
fred.spray_paint('red')
p fred.color
p fred.year
