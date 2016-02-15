class Human
  def initialize(args)
    @name = args[:name]
  end

  def eat
    "NOM NOM NOM"
  end


end

class Parent < Human

  attr_reader :kids, :name
  def initialize(args)
    @kids = args.fetch(:kids, [])
  end

  def add_kid(new_kid)
    if new_kid.class == Kid
      @kids << new_kid
    else
      @kids << Kid.new(new_kid)
    end
  end

end

class Kid < Human

  def initialize(args = {})
    super
    @weight = args[:weight]
    @age = args[:age]
    @height = args[:height]
  end

  def bite
    "My teeth are sharp NOM NOM NOM"
  end



end

p tommy = Kid.new(name: "Tommy")
p timmy = Kid.new(name: "TomTimToeBob", age: 37, weight: 96, height: "5'11")

p timmy.bite

mom = Parent.new(name: "Tammy")
mom.add_kid(name: "TomTimToeBob", age: 37, weight: 96, height: "5'11")
mom.add_kid(tommy)
p mom.kids
p mom.eat
