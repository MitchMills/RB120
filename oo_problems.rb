### OO BASICS: CLASSES AND OBJECTS II
## 01

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
