class Animal
  def speak(sound)
    puts "#{sound}"
  end
end

class Horse < Animal
  attr_reader :sound

  def initialize
    @sound = 'Neigh!'
  end
end

class Cat < Animal
  attr_reader :sound

  def initialize
    @sound = 'Meow!'
  end
end

class Dog < Animal
  attr_reader :sound

  def initialize
    @sound = 'Woof!'
  end
end

class Bird < Animal
  attr_reader :sound

  def initialize
    @sound = 'Tweet!'
  end
end

all_animals = [Horse.new, Cat.new, Dog.new, Bird.new]

all_animals.each do |animal|
  animal.speak(animal.sound)
end
