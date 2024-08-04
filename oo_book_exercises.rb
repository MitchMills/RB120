class Student
  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(other_student)
    grade > other_student.grade
  end

  protected
  attr_reader :grade
end

fred = Student.new('Fred', 99)
mike = Student.new('Mike', 88)
p fred.better_grade_than?(mike)

############
# class Vehicle
#   attr_accessor :color
#   attr_reader :year, :model
#   @@number_of_vehicles = 0

#   def self.number_of_vehicles
#     puts "Number of vehicles: #{@@number_of_vehicles}"
#   end

#   def self.gas_mileage(miles_driven, gallons_used)
#     mpg = miles_driven.fdiv(gallons_used).round(2)
#     puts "Your gas mileage is #{mpg} miles per gallon."
#   end

#   def initialize(year, color, model)
#     @year = year
#     self.color = color
#     @model = model
#     @current_speed = 0
#     @@number_of_vehicles += 1
#   end

#   def age
#     "Your #{color} #{model} is #{car_age} years old."
#   end

#   def accelerate(amount)
#     @current_speed += amount
#     puts "Accelerating by #{amount} miles per hour."
#     current_speed
#   end

#   def decelerate(amount)
#     @current_speed -= amount
#     puts "Decelerating by #{amount} miles per hour."
#     current_speed
#   end

#   def current_speed
#     puts "Your current speed is now #{@current_speed} miles per hour."
#   end

#   def turn_off
#     @current_speed = 0
#     puts "You have turned off the vehicle."
#   end

#   def spray_paint(color)
#     former_color = self.color
#     self.color = color
#     puts "Your formerly #{former_color} car is now #{color}!"
#   end

#   def to_s
#     "#{year} #{color} #{model}"
#   end

#   private

#   def car_age
#     Time.now.year - self.year
#   end
# end

# module CargoTasks
#   def load_bed(material)
#     puts "Putting #{material} in the bed."
#   end

#   def emtpy_bed
#     puts "Emptying the bed."
#   end
# end

# class MyCar < Vehicle
#   NUMBER_OF_DOORS = 4

#   def to_s
#     "This car is a " + super + "."
#   end
# end

# class MyTruck < Vehicle
#   include CargoTasks

#   NUMBER_OF_DOORS = 2

#   def to_s
#     "This truck is a " + super + "."
#   end
# end

# fred = MyCar.new(2015, 'silver', 'honda fit')
# puts fred.age
