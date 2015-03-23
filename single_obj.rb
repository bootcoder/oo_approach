module Ringer
  def ring
    p "I am ringing.. ringing"
  end
end




class AlarmClock
  include Ringer
    # use include to include module methods as instance methods on the class.
    # use extent to include them as class methods.

  def initialize
    @time = "now"
  end

end





class Bicycle
  include Ringer
  attr_reader :wheel_size
  def initialize(args={})
    @wheel_size = 29
    @type= args[:type]
    p "You've created a bicycle"
  end
  def pedal
    p "I am pedaling. My wheel_size is #{@wheel_size} I go fast"
  end

  def jumping
    p "I am jumping!" if @type == "mountain bike"
  end

end





class MountainBike
  def initialize(args={})
    @wheel_size = 26
    p "Wheel size is : #{@wheel_size}"
  end

  def pedal
    p "I am pedaling. I go fast"
  end

  def jumping
    p "I am jumping!"
  end
end


b=Bicycle.new({wheel_size: 26})
b.pedal
b.ring


a = AlarmClock.new
a.ring


#
