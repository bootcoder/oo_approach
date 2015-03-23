# Composition is used when the "has-a" relationship exists.  A bicycle has parts.

class Bicycle
  def initialize(size,parts)
    @size = size
    @parts = parts # This is an example of dependency injection - we inject the dependency that Bicycle has on Parts
  end

  def pedal
    p "I am pedalling and going #{gear_ratio * wheel_size} miles an hour"
  end
  # encapulate the dependecy of the Parts object into methods
  # private # optional to make these private if not needed outside the class

  def gear_ratio
    @parts.gear_ratio * 0.12
  end

  def wheel_size
    @parts.wheel_size
  end

end

class Parts
  attr_reader :wheel_size
  def initialize(args={})
    @wheel_size=args[:wheel_size]
    @tire_type = args[:tire_type]
    @rear_sus=args[:rear_sus]
  end

  def gear_ratio
    1
  end

end

# ============= Driver Code ============================

mtnbikeparts = Parts.new({wheel_size:29, tire_type:"Big", rear_sus: "lots"})
mountbike= Bicycle.new(15, mtnbikeparts)
mountbike.pedal
