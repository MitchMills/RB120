

### QUESTION TWO
=begin
A module is a collection of behaviors (methods) that can be used by other classes if the module is included ("mixed in") in the class definition.

One purpose of a module is to group a set of behaviors / methods in one place so that they can be used by multiple classes without having to duplicate these methods within the classes themselves.

A module can be used by a class if the `#include` method is used in the definition of that class, with the module name as an argument.
=end

# module Audible
#   def make_sound(sound)
#     puts sound
#   end
# end

# class Cat
#   include Audible
# end

# chumley = Cat.new
# chumley.make_sound('meow!')

=begin
A module is a collection of behaviors (methods) and/or constants. One purpose of modules is to enable multiple classes to access common constants and/or methods without having to duplicate them in each class.

A module can be used with a class by invoking the `#include` method, followed by the module's name, within the definition of that class.
=end

# module Steerable
#   def turn_left
#     puts "Turning left"
#   end
# end

# class Vehicle
#   include Steerable
# end

# car = Vehicle.new
# car.turn_left

### QUESTION ONE
=begin
We create an object in Ruby by invoking the `#new` method on either a built-in class, or a custom class that we have defined. This creates an instance of that class.
=end

# my_string = String.new('Hello World!')

# class MyClass

# end

# my_object = MyClass.new

# puts my_string
# puts my_object

=begin
We can create an object in Ruby by invoking the `#new` method on an existing class (whether built-in or custom). This instantiates a new instance of that class.
=end

# class Vehicle; end

# car = Vehicle.new
# p car
