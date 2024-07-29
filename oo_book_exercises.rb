module MyModule

end

class MyClass
  include MyModule
end

object1 = MyClass.new
p MyClass.ancestors
