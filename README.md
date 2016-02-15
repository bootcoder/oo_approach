## Object Oriented Problem Solving

### Vocab Quiz!

- class
- object
- instance
- instantiation
- inheritance
- composition
- encapsulation
- attribute
- method
- is-a relationship (inheritance)
- has-a relationship (composition)
- interface (API)
















### Example Time: Volunteer Coordination App

We're writing some software to help our friend Lynne organize the enthusiastic volunteer base for the Joshua Tree Music Festival.  The volunteers do a lot of jobs that keep the festival running.  For example, they collect the trash, check wristbands at the festival gate, provide childcare at the kids booth, direct traffic in the parking lots, serve beer at the beer garden, and so much more ...

Lynne's been using a spreadsheet to keep track of what the jobs are, when these jobs need to be done, and who's signed up for what job and time slot.  Now she would like us to create an app that will let her set up the jobs, then have volunteers sign up for the 3 time slots that work for them.  Then Lynne can review the list of volunteers signed up for each job at each time slot.













### User Stories
- As a coordinator, I need to define the different kinds of volunteering jobs.
- As a coordinator, I need to define the shifts when each volunteering job is to be done.
- As a volunteer, I need to see a list of all the available jobs and pick one that I can perform.
- As a volunteer, I need to sign up for 3 shifts of a particular job.
- As a coordinator, I need to see which volunteers are signed up for jobs and shifts.















### Nouns and Verbs
- nouns: jobs, shifts, volunteers, coordinator














### Sketching the Objects
- Job
  - Attributes: name, shifts
  - Methods: define jobs, list jobs, list shifts for a job, sign up for jobs
- Volunteer
  - Attributes: name, job, shifts
  - Methods: sign_up
- Shift
  - Attributes: time
  - Methods: define shifts

- verbs: , , , , , list volunteers for a job, list volunteers for a shift, list a volunteer's job and shifts.











### Design Decision Driver Code
```ruby
# Which one of these do we prefer and why?
# What OO design choices does each line reflect?

volunteer.sign_up(job)
job.sign_up(volunteer)




coordinator.sign_up(volunteer, job)

system.sign_up(volunteer, job)

```












### Changing Requirements

Lynne now wants to be able to limit the number of volunteers for each shift, because some jobs and shifts are more popular than others.  How would you change the design to reflect this new requirement?  Which object should encapsulate this new information?  How should it be stored?  See if you can add this code on your own.










