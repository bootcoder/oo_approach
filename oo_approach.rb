# var == regular var
# @var == instance var

# @@var == class var
# $var == global var

class Shift

  attr_reader :time

  def initialize(time = "1234")
    @time = time
  end

  def to_s
    "#{@time}"
  end

end


class Job
  attr_reader :name, :shifts

  def initialize(name:, shifts:)
    @name = name
    @shifts = shifts
  end

  def to_s
    "\n------------------\n #{@name} \n------------------\n Shifts: #{@shifts.join(", ")}"
  end
end







class Volunteer
  attr_reader :name, :job, :shifts

  def initialize(name:)
    @name = name
  end

  def sign_up(job:, shifts:)
    @job = job
    @shifts = shifts
  end

  def to_s
    "#{@name} is signed up for #{@job.name} on #{@shifts.join(", ")}"
  end
end















module ShiftFactory
  #self.create --theres like 7 or 8 ways to make this happen. this is a good point to
  # expose students to it.
  def self.create(times:)
    times.map { |time| Shift.new({:time => time}) }
  end

end

module JobFactory

  def self.create(jobs:)
    jobs.map { |job| Job.new({:name => job.fetch(:name),
                              :shifts => job.fetch(:shifts)}) }
  end
end























### Driver Code
shift = Shift.new("209384")

puts shift.methods

__END__

# Create some shifts with a factory
shifts = ShiftFactory.create({:times => ["Saturday morning",
                                         "Saturday afternoon",
                                         "Saturday night",
                                         "Sunday morning",
                                         "Sunday afternoon",
                                         "Sunday night"]})
# Create some jobs with a factory
jobs = JobFactory.create({:jobs => [
                                    {:name => "Childcare",          :shifts => shifts},
                                    {:name => "Bartending",         :shifts => shifts},
                                    {:name => "Wristband Checking", :shifts => shifts},
                                    {:name => "Parking Lot",        :shifts => shifts}
                                  ]})
# Let's take a look at them


puts "Here are the available volunteer jobs."
puts jobs
puts ""

# Create a volunteer and sign him up for a job and some shifts

volunteer_johnjoe = Volunteer.new({:name => "JohnJoe Jones"})
volunteer_johnjoe.sign_up({:job => jobs.first, :shifts => shifts.sample(3)})
puts volunteer_johnjoe



