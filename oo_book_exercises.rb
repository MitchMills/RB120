class MyCar
  attr_accessor :color
  attr_reader :year, :model

  def initialize(year, color, model)
    @year = year
    self.color = color
    @model = model
    @current_speed = 0
  end

  def get_info
    puts "This car is a #{@year} #{@color} #{@model}."
  end

  def speed_up(amount)
    @current_speed += amount
    puts "Speeding up by #{amount} mph."
  end

  def slow_down(amount)
    @current_speed -= amount
    puts "Slowing down by #{amount} mph."
  end

  def stop
    @current_speed = 0
    puts "Stopping."
  end

  def current_speed
    puts "Current speed is now #{@current_speed} mph."
  end

  def spray_paint(color)
    self.color = color
  end
end

fred = MyCar.new(1997, 'red', 'vibe')
fred.get_info
fred.spray_paint('blue')
fred.get_info
