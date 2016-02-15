# --------------------------------------------------------
# variable scope: understanding where a variable "lives"
# --------------------------------------------------------
#
# in Ruby there are:
#   - 4 kinds of variable scope:
#
#     - global ($db, $connection, $file)
#     - class (@@total, @@poolsize)
#     - instance (@age, @name)
#     - local (counter, element, result)
#
#   - and 1 constant type (MAX_SIZE, Student, Enumerable)

# when you declare a variable you use the first character to indicate it's scope as per the examples above.

# knowing when a variable is in (or out) of scope is critical to understanding program flow

# you're suffering from which-scope-itis if you're asking youself questions like these:
# - why doesn't my method see this variable declared before it? should it be an instance variable?
# - does my block know about the variables declared before the block?
# - how do i get the instance variable out of that class?
# - why does this variable always come back as nil?

# while you're learning about this you can use the Object#defined? method to discover the scope of a variable

a = 10
puts defined? a  #=> 'local-variable'

$b = 15
puts defined? $b  #=> 'global-variable'

puts "--------------------------------------------------------"
puts "--------------------------------------------------------"

# --------------------------------------------------------
# local variables
# --------------------------------------------------------

# local variables start with a lowercase letter or an underscore
_counter = 0

# they are available to the current scope
#   so if you're not inside a method, just right at the top level of a Ruby file ...
until _counter > 3
  puts _counter += 1
end

#   or if you are *already* inside a method, local variables get stuck in there
def say_hello
  me = "Chris P. Bacon"
  puts "hello from #{me}"
end

#   notice how you can't get at the variable 'me' out here
# puts me
  #!!!=> undefined local variable or method `me' for main:Object (NameError)

puts "--------------------------------------------------------"
puts "--------------------------------------------------------"

# --------------------------------------------------------
# global variables
# --------------------------------------------------------

# global variables start with a dollar sign ($) because they're so boujie
$look_at_me_evreebady = 100

p $look_at_me_evreebady

# the reason people don't like using global variables is easy to understand if you appreciate
# the problems they cause.  imagine a big program, like more than 10,000 lines long, and a few
# hundred global variables floating around all over the place, because that's what they do.  since
# the global variables are available everywhere, they can also be changed from anywhere.  imagine
# how hard it would be to track down every place in your 10,000 lines of code that *might* be changing
# your global variable.  they basically make troubleshooting more complicated.

puts "--------------------------------------------------------"
puts "--------------------------------------------------------"

# --------------------------------------------------------
# interlude ...
# --------------------------------------------------------
# constants (and classes and modules)
# --------------------------------------------------------

# constants start with a capital letter and they're available everywhere, like global variables
FILENAME = 'data.txt'

# but the Ruby intepreter warns you if you try to change them.  that's helpful.
# FILENAME = 'other_data.csv'
  #=> warning: already initialized constant FILENAME
  #=> warning: previous definition of FILENAME was here


# surprise, surprise, classes and modules also start with capital letters
# that's because they're constants too!
class Student; end
module Teachable; end

# constants defined in the main scope like FILENAME above are available everywhere
class Student
  DEFAULT_EMAIL = 'student@devbootcamp.com'
end

# but constants defined inside of a module or class are locked in there
# puts DEFAULT_EMAIL
  #!!! uninitialized constant DEFAULT_EMAIL (NameError)

# but we can get at them by appropriated scoping their name like this
puts Student::DEFAULT_EMAIL

# --------------------------------------------------------

# modules are used in Ruby to solve 2 problems:
# - organizing names
# - organizing methods

# modules are used to create what are called "namespaces" for classes
#   which means you can have similarly named classes that play nicely together
#   without overriting each other
module DBC
  module SanFrancisco
    class Student
      def play
        "let's go for a hike!"
      end
    end
  end

  module Chicago
    class Student
      def play
        "let's go for a walk along the lake!"
      end
    end
  end

  module NewYork
    class Student
      def play
        "let's go for some Brazilian jazz!"
      end
    end
  end
end

topher = DBC::SanFrancisco::Student.new
sam = DBC::Chicago::Student.new
sunny = DBC::NewYork::Student.new

puts topher.play  #=> let's go for a hike!
puts sam.play  #=> let's go for a walk along the lake!
puts sunny.play  #=> let's go for some Brazilian jazz!


# incidentally, modules are also used to organize methods into logical groups that can be "mixed-in" to a class
#   and this is why modules are sometimes called mixins by Rubyists

module Teachable
  def learn!
    "ok, got it, thanks."
  end

  def forget!
    "what were we talking about again?"
  end

  def rejoice!
    "i've never felt so capable and energized!"
  end
end

# note that this class is different from all Student classes declared in the DBC module above
class Student
  include Teachable
end

brighton_early = Student.new
puts brighton_early.learn!  #=> ok, got it, thanks.
puts brighton_early.rejoice!  #=> i've never felt so capable and energized!

puts "--------------------------------------------------------"
puts "--------------------------------------------------------"

# --------------------------------------------------------
# instance variables
# --------------------------------------------------------

# instance variables are stored within the instance of a class
# and basically float around anywhere between the words "class" ... and ... "end"
# so you can use them across methods inside the same class
class Student
  def initialize(n)
    @name = n
  end

  def say_hello
    "hi, my name is #{@name}"
  end
end

student1 = Student.new('Dan Druff')
student2 = Student.new('Seymour Butts')

puts student1.say_hello #=> hi, my name is Dan Druff
puts student2.say_hello #=> hi, my name is Seymour Butts

# if you want to get at the instance variables outside of the class then you have to expose them
class Student
  def get_name
    @name
  end
end

puts student1.get_name #=> Dan Druff
puts student2.get_name #=> Seymour Butts

# but that move is so common among programmers that Ruby has some built-in helpers for it
class Student
  attr_reader :name

  # attr_reader does nothing more than generate the method that is commented out below this line
  # def name
  #   @name                  # notice that the instance variable is returned by the method
  # end
end

puts student1.name #=> Dan Druff
puts student2.name #=> Seymour Butts

# attr_reader has 2 friends: attr_writer and attr_accessor
class You
  attr_reader :name  # readers are for things the world needs but won't change in instances of the class
  attr_writer :cohort # writers are for things the world will change in instances of the class
  attr_accessor :paired_with # accessors are for things that may be read and written over the life of the class

  # the line ... [attr_reader :name] ... generates this method:
  # def name
  #   @name                  # notice that the instance variable is returned by the method
  # end

  # the line ... [attr_writer :cohort] ... generates this method:
  # def cohort=(cohort)
  #   @cohort = cohort       # notice that the instance variable is assigned by the method
  # end

  # the line ... [attr_accessor :paired_with] ... generates these methods:
  # def paired_with
  #   @paired_with           # notice that the instance variable is returned by the method
  # end
  #
  # def paired_with=(pair)
  #   @paired_with = pair    # notice that the instance variable is assigned by the method
  # end
end

# but you can't get access to the instance variables inside a class from outside the class
p @name  #=> nil (since it's undefined in this scope)

# and if you want two classes to share data they have to communicate through their interface (methods)

class A
  attr_reader :x
  def initialize
    @x = "hello from [class #{self.class.name}]"
  end

  def call_to_top
    top_level_method
  end

end

class B
  def investigate_class_A
    a = A.new
    puts a.x   # this line only works because [A] exposes a reader on [x]
  end

  def call_to_top
    top_level_method
  end

end

b = B.new
b.investigate_class_A #=> "hello from [class A]"

# as a side note on what people call the Top-Level, basically the indentation level we're at right now ...
def top_level_method
  puts "hello from [class #{self.class.name}]"
end

top_level_method # => hello from [class Object]  # the Top-Level is actually a running instance of Object  :)

# and here's a special case how "self" changes when classes call top level methods
A.new.call_to_top # => hello from [class A] # weird, huh? the meaning of "self" changes depending on where this method is called.
B.new.call_to_top # => hello from [class B] # weird, huh? the meaning of "self" changes depending on where this method is called.

# the above quirk only happens when classes use methods defined at the top level

puts "--------------------------------------------------------"
puts "--------------------------------------------------------"

# --------------------------------------------------------
# class variables
# --------------------------------------------------------

# class variables are data stored with the class

class C
  @@x = nil
  # if we don't declare this here we'll get an error the first time we try to [read] it:
  #   => uninitialized class variable @@x in C (NameError)
  # but note that we can [write] to it without first declaring it of course ... because that's literally just like declaring it

  def self.read
    print "[ class #{self} ] is reading @@x as: "
    p @@x
    puts
  end

  def self.write
    @@x = true
    print "[ class #{self} ] is setting @@x to: "
    p @@x
    puts
  end
end

class D < C
  def self.write
    @@x = false
    print "[ class #{self} ] is setting @@x to: "
    p @@x
    puts
  end
end

C.read # => [ class C ] is reading @@x as: nil
D.read # => [ class D ] is reading @@x as: nil

C.write # => [ class C ] is setting @@x to: true

C.read # => [ class C ] is reading @@x as: true
D.read # => [ class D ] is reading @@x as: true

D.write # => [ class D ] is setting @@x to: false

D.read # => [ class D ] is reading @@x as: false
C.read # => [ class C ] is reading @@x as: false   # <--- this is the reason people say "class variables are bad" -- it's because they increase complexity through entanglement

# the conclusion to draw here is this:
# - when you use class variables, you're declaring a variable that is globally writeable by all classes in your hierarchy.
#   - it's like having one shared variable among all your classes in a particular hierarchy

# the reason this is "bad" isn't for some intrinsic quality, it's only because it's surprising.
# if you can call OOP "typical", then in typical OOP, class variables can't be modified like this, they behave more like class instance variables in the next section
# but this is still a totally viable place to store data if you understand that subclasses can modify its value.



## NEED EXPO on class << self thingy
class Person
  @@count = 0  # setup a class variable to count all the people
  class << self
    def count # expose that variable on the class's public interface, ie. Person.count
      @@count
    end
    def add_people(num)  # and allow the number to be increased
      @@count += num
    end
  end

  def initialize
    Person.add_people(1)  # whenever we make a new Person we can count them
  end
end

class DBCStudent < Person; end

class DBCTeacher < Person; end


(1..3).each do |phase_num|
  puts "phase #{phase_num} walking in ..."
  puts "oh look, we have #{t = rand(1..3)} phase #{phase_num} teacher(s) ..."
  Array.new(t) { DBCTeacher.new }
  puts "and here come #{s = rand(20..25)} phase #{phase_num} students ..."
  Array.new(s) { DBCStudent.new }
  puts
end

puts "there are #{Person.count} people at DBC right now"

# and this is bit of a stretch, I know, bear with me and imagine that there's this idea of a fire drill participant. if one leaves, everyone leaves
class FireDrillParticipant < Person
  def leaves_the_building
    puts "hey, i smell smoke!  i think there's a fire!!!"
    self.class.add_people(-self.class.count)  # here we subtract from count whatever it's value to set it to zero
  end
end

sensitive_to_smoke = FireDrillParticipant.new
sensitive_to_smoke.leaves_the_building

puts "there are #{Person.count} people left in DBC after someone yelled 'fire'"


puts "--------------------------------------------------------"
puts "--------------------------------------------------------"

# --------------------------------------------------------
# class instance variables
# --------------------------------------------------------

# say what?!

# this section coulda-shoulda-woulda been included in the section on instance variables
# but it's easier to explain in terms of that and the section on class variables above.

# here's a quick recap:
# - OOP is about organizing your code so that the names of things, the data they hold  (encapsulated
#   variables) and their behavior (methods on their interface), all conspire towards a model of the problem
#   you're trying to solve or whatever system you're trying to mimic.  that's basically it.
# - tools of expression in OOP include:
#   - [classes] are templates that define a logical grouping of data and behavior
#   - [objects] or [instances] are things made from those templates that model one or parts in the system being modeled
#   - [variables] or [attributes] or [properties] are data attached to classes or objects
#     - [class variables] are data attached to classes
#     - [instance variables] are data attached to objects
#   - [methods] or [behavior] or [messages] are named chunks of code attached to classes or objects
#     - [class methods] are behaviors attached to classes
#     - [instance methods] are behaviors attached to objects

# if all the above is clear enough then:
#     - [class instance variables] are like [class variables] in that they are data attached to classes
#       - but class instance variables are not writable throughout the inheritance hierarchy


class E
  # @y = nil  # we DON'T need to declare class instance variables since they're set to nil on first use (read or write)

  def self.read
    print "[ class #{self} ] is reading @y as: "
    p @y
    puts
  end

  def self.write
    @y = true
    print "[ class #{self} ] is setting @y to: "
    p @y
    puts
  end

end

class F < E
  def self.write
    @y = false
    print "[ class #{self} ] is setting @y to: "
    p @y
    puts
  end
end

E.read # => [ class E ] is reading @y as: nil
F.read # => [ class F ] is reading @y as: nil

E.write # => [ class E ] is setting @y to: true

E.read # => [ class E ] is reading @y as: true
F.read # => [ class F ] is reading @y as: nil

F.write # => [ class F ] is setting @y to: false

F.read # => [ class F ] is reading @y as: false
E.read # => [ class E ] is reading @y as: true    # notice here that the class instance variable isn't changed

puts "--------------------------------------------------------"
puts "--------------------------------------------------------"

# --------------------------------------------------------
# resources
# --------------------------------------------------------

# Ruby variables in general
# http://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Variables_and_Constants

# what is Top-Level
# http://banisterfiend.wordpress.com/2010/11/23/what-is-the-ruby-top-level/

# class instance variables
# http://www.railstips.org/blog/archives/2006/11/18/class-and-instance-variables-in-ruby/
