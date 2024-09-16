### QUESTION TWO
=begin
A module is a collection of behaviors (methods) that can be used by other classes if the module is included ("mixed in") in the class definition.

One purpose of a module is to group a set of behaviors / methods in one place so that they can be used by multiple classes without having to duplicate these methods within the classes themselves.

A module can be used by a class if the `#include` method is used in the definition of that class, with the module name as an argument.
=end

module Audible
  def make_sound(sound)
    puts sound
  end
end

class Cat
  include Audible
end

chumley = Cat.new
chumley.make_sound('meow!')


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
