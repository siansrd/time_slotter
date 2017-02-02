require 'time'

class TimeSlotter

  attr_accessor :start, :duration, :breaks, :students

  def initialize()
    @start = nil
    @duration = nil
    @breaks = {}
    @students = %w( 
      Suzanne
      Bob
      Adam
      Graeme
      Robert
      Lewis
      Chris
      Ewen
      Ross
      Douglas
      Colin
      Rob
      David
      Leon
      Alice
      Josef
      Kim
      Richard
      Ferdinando
      Simon
    )
  end


  def print_list(names_list, start, duration, breaks)

    names_list.each do |name|

      start_time = date_to_time(start)

      breaks.each do |key, value|
        if key == start_time 
          puts "#{start_time}: BREAK"
          start = start + value*60
          start_time = date_to_time(start)
        end
      end

      puts "#{start_time}: #{name}"
      start = start + duration*60  
    end

    get_break_details(breaks)
  end

  def get_break_details(breaks)
    print "Want to add a break? Enter time (in 24hr) : "
    break_time = gets.chomp
    print "How long should the break be? (mins): "
    break_duration = gets.to_i
    breaks[break_time] = break_duration
    print_list(breaks)
  end



  def get_duration()
    print "How long do you want the time slots to be? (in mins)? : "
    duration = gets.to_i
    return duration
  end

  def get_start_time()
    print "What do you want as the start time? (in 24hr) : "
    get_time = gets.chomp
    start_date_time = Time.parse(get_time)
    return start_date_time
  end

  def date_to_time(date)
    return date.strftime("%H:%M")
  end

  def add_break(time, duration)
    breaks = {
      time => duration
    }
  end

end

# ------------

students = students.shuffle()

puts "*** Time Slotter! ***"
duration = get_duration()
start_date_time = get_start_time()
print_list(students, start_date_time, duration, breaks)
get_break_details(breaks)




