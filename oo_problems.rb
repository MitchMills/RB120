### OO EASY 1
## 01 Banner Class
# class Banner
#   def initialize(message, width = (message.size + 2))
#     @message = message
#     @width = width
#   end

#   def to_s
#     minimum_width = message.size + 2
#     if width < minimum_width
#       "Provided width must be at least #{minimum_width} for message to fit."
#     elsif width > 80
#       "Provided width must be no greater than 80."
#     else
#       [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
#     end
#   end

#   private

#   attr_reader :message, :width

#   def horizontal_rule
#     "+#{'-' * width}+"
#   end

#   def empty_line
#     "|#{' ' * width}|"
#   end

#   def message_line
#     "|#{message.center(width)}|"
#   end
# end

# banner = Banner.new('To boldly go where no one has gone before.', 30)
# puts banner
# banner = Banner.new('', 3)
# puts banner

# class Banner
#   def initialize(message)
#     @message = message
#     @width = message.size + 2
#   end

#   def to_s
#     [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
#   end

#   private

#   attr_reader :message, :width

#   def horizontal_rule
#     "+#{'-' * width}+"
#   end

#   def empty_line
#     "|#{' ' * width}|"
#   end

#   def message_line
#     "| #{message} |"
#   end
# end

# banner = Banner.new('To boldly go where no one has gone before.')
# puts banner
# banner = Banner.new('')
# puts banner

### OO BASICS: ACCESSOR METHODS
## 10 Unexpected Change
# class Person
#   def name=(full_name)
#     @first_name, @last_name = full_name.split
#   end

#   def name
#     "#{first_name} #{last_name}"
#   end

#   private

#   attr_reader :first_name, :last_name


# end

# person1 = Person.new
# person1.name = 'John'
# puts person1.name # => John Doe

## 09 Calculated Age
# class Person
#   def age=(age)
#     @age = double(age)
#   end

#   def age
#     double(@age)
#   end

#   private

#   def double(number)
#     number * 2
#   end
# end

# person1 = Person.new
# person1.age = 20
# puts person1.age

## 08 Avoid Mutation
# class Person
#   def initialize(name)
#     @name = name
#   end

#   def name
#     @name.clone
#   end
# end

# person1 = Person.new('James')
# person1.name.reverse!
# puts person1.name

## 07 Prefix the Name
# class Person
#   attr_writer :name

#   def name
#     "Mr. #{@name}"
#   end
# end

# person1 = Person.new
# person1.name = 'James'
# puts person1.name

## 06 Guaranteed Formatting
# class Person
#   attr_reader :name

#   def name=(name)
#     @name = name.capitalize
#   end
# end

# person1 = Person.new
# person1.name = 'eLiZaBeTh'
# puts person1.name

## 05 Who is Older?
# class Person
#   attr_writer :age

#   def older_than?(other)
#     age > other.age
#   end

#   protected

#   attr_reader :age
# end

# person1 = Person.new
# person1.age = 17

# person2 = Person.new
# person2.age = 26

# puts person1.older_than?(person2)
# puts person2.older_than?(person1)

## 04 Comparing Names
# class Person
#   attr_accessor :first_name
#   attr_writer :last_name

#   def first_equals_last?
#     first_name == last_name
#   end

#   private

#   attr_reader :last_name
# end

# person1 = Person.new
# person1.first_name = 'Dave'
# person1.last_name = 'Smith'
# puts person1.first_equals_last?

## 03 Access Denied
# class Person
#   attr_reader :phone_number

#   def initialize(number)
#     @phone_number = number
#   end
# end

# person1 = Person.new(1234567899)
# puts person1.phone_number

# person1.phone_number = 9987654321
# puts person1.phone_number

## 02 Choose the Right Method
# class Person
#   attr_accessor :name
#   attr_writer :phone_number
# end

# person1 = Person.new
# person1.name = 'Jessica'
# person1.phone_number = '0123456789'
# puts person1.name

## 01 Reading and Writing
# class Person
#   attr_accessor :name
# end

# person1 = Person.new
# person1.name = 'Jessica'
# puts person1.name

### OO BASICS: INHERITANCE
## 10 Transportation
# module Transportation
#   class Vehicle
#   end

#   class Truck < Vehicle
#   end

#   class Car < Vehicle
#   end
# end

## 09 Method Lookup III
# module Flyable
#   def fly
#     "I'm flying"
#   end
# end

# class Animal
#   attr_reader :color

#   def initialize(color)
#     @color = color
#   end
# end

# class Cat < Animal
# end

# class Bird < Animal
#   include Flyable
# end

# bird1 = Bird.new('Red')
# bird1.color

# Bird
# Flyable
# Animal

## 08 Method Lookup II
# class Animal
# end

# class Cat < Animal
# end

# class Bird < Animal
# end

# cat1 = Cat.new
# cat1.color

# Cat
# Animal
# Object
# Kernel
# BasicObject

## 07 Method Lookup I
# class Animal
#   attr_reader :color

#   def initialize(color)
#     @color = color
#   end
# end

# class Cat < Animal
# end

# class Bird < Animal
# end

# cat1 = Cat.new('Black')
# p cat1.color

## 06 Towable II
# module Towable
#   def tow
#     'I can tow a trailer!'
#   end
# end

# class Vehicle
#   attr_reader :year

#   def initialize(year)
#     @year = year
#   end
# end

# class Truck < Vehicle
#   include Towable
# end

# class Car < Vehicle
# end

# truck1 = Truck.new(1994)
# puts truck1.year
# puts truck1.tow

# car1 = Car.new(2006)
# puts car1.year

## 05 Towable I
# module Towable
#   def tow
#     puts "I can tow a trailer!"
#   end
# end

# class Truck
#   include Towable
# end

# class Car
# end


# truck1 = Truck.new
# truck1.tow

## 04 Start the Engine II
# class Vehicle
#   def start_engine
#     'Ready to go!'
#   end
# end

# class Truck < Vehicle
#   def start_engine(speed)
#     super() + " Drive #{speed}, please!"
#   end
# end

# truck1 = Truck.new
# puts truck1.start_engine('fast')

## 03 Only Pass the Year
# class Vehicle
#   attr_reader :year

#   def initialize(year)
#     @year = year
#   end
# end

# class Truck < Vehicle
#   attr_reader :bed_type

#   def initialize(year, bed_type)
#     super(year)
#     @bed_type = bed_type
#   end
# end

# class Car < Vehicle
# end

# truck1 = Truck.new(1994, 'Short')
# puts truck1.year
# puts truck1.bed_type

## 02 Start the Engine I
# class Vehicle
#   attr_reader :year

#   def initialize(year)
#     @year = year
#   end
# end

# class Truck < Vehicle
#   def initialize(year)
#     super
#     start_engine
#   end

#   def start_engine
#     puts 'Ready to go!'
#   end
# end

# truck1 = Truck.new(1994)
# puts truck1.year

## 01 Inherited Year
# class Vehicle
#   attr_reader :year

#   def initialize(year)
#     @year = year
#   end
# end

# class Truck < Vehicle
# end

# class Car < Vehicle
# end

# truck1 = Truck.new(1994)
# puts truck1.year

# car1 = Car.new(2006)
# puts car1.year

### OO BASICS: CLASSES AND OBJECTS II
## 10 PROTECTED SECRET
# class Person
#   attr_writer :secret

#   def compare_secret(other_person)
#     secret == other_person.secret
#   end

#   protected

#   attr_reader :secret
# end

# person1 = Person.new
# person1.secret = 'Shh... this is a secret!'

# person2 = Person.new
# person2.secret = 'Shh... this is a different secret!'

# puts person1.compare_secret(person2)

## 09 PRIVATE SECRET
# class Person
#   attr_writer :secret

#   def share_secret
#     puts secret
#   end

#   private

#   attr_reader :secret
# end

# person1 = Person.new
# person1.secret = 'Shh... this is a secret!'
# person1.share_secret

## 08 PUBLIC SECRET
# class Person
#   attr_accessor :secret
# end

# person1 = Person.new
# person1.secret = 'Shh... this is a secret!'
# puts person1.secret

## 07 IDENTIFY YOURSELF II
# class Cat
#   attr_reader :name

#   def initialize(name)
#     @name = name
#   end

#   def to_s
#     "I'm #{name}!"
#   end
# end

# kitty = Cat.new('Sophie')
# puts kitty

## 06 COLORFUL CAT
# class Cat
#   COLOR = 'purple'
#   attr_accessor :name

#   def initialize(name)
#     self.name = name
#   end

#   def greet
#     puts "Hello! My name is #{name} and I'm #{COLOR}!"
#   end
# end

# kitty = Cat.new('Sophie')
# kitty.greet

## 05 COUNTING CATS
# class Cat
#   @@number_of_cats = 0

#   def initialize
#     @@number_of_cats += 1
#   end

#   def self.total
#     puts @@number_of_cats
#   end
# end

# kitty1 = Cat.new
# kitty2 = Cat.new

# Cat.total

## 04 Generic Greeting II
# class Cat
#   attr_reader :name

#   def initialize(name)
#     @name = name
#   end

#   def personal_greeting
#     puts "Hello! My name is #{name}!"
#   end

#   def self.generic_greeting
#     puts "Hello! I'm a cat!"
#   end
# end

# kitty = Cat.new('Sophie')

# Cat.generic_greeting
# kitty.personal_greeting

## 03 Identify Yourself I
# class Cat
#   attr_accessor :name

#   def initialize(name)
#     self.name = name
#   end

#   def identify
#     self
#   end
# end

# kitty = Cat.new('Sophie')
# p kitty.identify
# p kitty

## 02 Hello, Chloe!
# class Cat
#   attr_accessor :name

#   def initialize(name)
#     self.name = name
#   end

#   def rename(new_name)
#     self.name = new_name
#   end
# end

# kitty = Cat.new('Sophie')
# p kitty.name
# kitty.rename('Chloe')
# p kitty.name

## 01 Generic Greeting I
# class Cat
#   def self.generic_greeting
#     puts "Hello! I'm a cat!"
#   end
# end

# Cat.generic_greeting
# kitty = Cat.new
# kitty.class.generic_greeting

### OO BASICS: CLASSES AND OBJECTS I
## 10 Walk the Cat
# module Walkable
#   def walk
#     puts "Let's go for a walk!"
#   end
# end

# class Cat
#   include Walkable

#   attr_accessor :name

#   def initialize(name)
#     self.name = name
#   end

#   def greet
#     puts "Hi! My name is #{name}!"
#   end
# end

# kitty = Cat.new('Sophie')
# kitty.greet
# kitty.name = 'Luna'
# kitty.greet
# kitty.walk

## 09 Accessor
# class Cat
#   attr_accessor :name

#   def initialize(name)
#     self.name = name
#   end

#   def greet
#     puts "Hello! My name is #{name}!"
#   end
# end

# kitty = Cat.new('Sophie')
# kitty.greet
# kitty.name = 'Luna'
# kitty.greet

## 08 Reader
# class Cat
#   attr_accessor :name

#   def initialize(name)
#     self.name = name
#   end

#   def greet
#     puts "Hello! My name is #{name}!"
#   end
# end

# kitty = Cat.new('Sophie')
# kitty.greet
# kitty.name = 'Luna'
# kitty.greet

## 07 Reader
# class Cat
#   attr_reader :name

#   def initialize(name)
#     @name = name
#   end

#   def greet
#     puts "Hello! My name is #{name}!"
#   end
# end

# kitty = Cat.new('Sophie')
# kitty.greet
# p kitty.name

## 06 Hello Sophie II
# class Cat
#   attr_accessor :name
#   def initialize(name)
#     self.name = name
#   end

#   def greet
#     puts "Hello! My name is #{name}!"
#   end
# end

# kitty = Cat.new('Sophie')
# kitty.greet

## 05 Hello Sophie I
# class Cat
#   attr_accessor :name
#   def initialize(name)
#     self.name = name
#     puts "Hello! My name is #{name}!"
#   end
# end

# kitty = Cat.new('Sophie')

## 04 What Are You?
# class Cat
#   def initialize
#     puts "I'm a cat!"
#   end
# end

# kitty = Cat.new

## 03 Create an Object
# class Cat
# end

# kitty = Cat.new

## 02 Create the Class
# class Cat
# end

## 01 Find the Class
# puts "Hello".class
# puts 5.class
# puts [1, 2, 3].class
