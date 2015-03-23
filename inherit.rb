class Bicycle
  attr_reader :wheel_size

  def initialize(args={})
    @wheel_size = args[:wheel_size] || 26
    @color = args[:color] || "red"
    p "You've created a bicycle"
  end

  def pedal
    p "I am pedaling. "
  end

end

class MountainBike < Bicycle

  def initialize(args={})
    super args
    p "wheel size : #{@wheel_size} and color : #{@color}"
  end

  def jumping
    p "I am jumping"
  end

end

class RoadBike < Bicycle
  def initialize(args={})
    super # note - we are not passing args so all road bikes are red.
    @wheel_size = 29
    p "wheel size : #{@wheel_size} and color : #{@color}"

  end

end



b=Bicycle.new({wheel_size: 26})
b.pedal

m=MountainBike.new({color: "blue"})
m.pedal

r=RoadBike.new
r.pedal









