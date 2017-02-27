require 'time'

class TimeSlotter

  attr_accessor :start, :duration, :breaks, :students

  def initialize()
    @start = nil
    @duration = nil
    @breaks = {}
    @students = nil
    @sessions = nil
  end

  def create_list
    file = File.open("list_of_names.txt")
    names = file.readlines { |line| names << line }
    @students = names
  end

  def create_sessions
    all_sessions = []
    session = []

    @students.each do |student|
      session << student
      if session.length == @sessions + 1
        all_sessions << session 
        session = []
      end
    end

    all_sessions << session if session.length > 0 
    return all_sessions
  end

  def add_times_to_sessions(all_sessions)
    all_sessions_with_times = []
    current_start = @start
    start_time = date_to_time(current_start)
    
    all_sessions.each do |session|

      @breaks.each do |break_time, break_duration| 
        if break_time == start_time
          all_sessions_with_times << { start_time => "----- BREAK -----" }
          current_start = current_start + break_duration*60
          start_time = date_to_time(current_start)
        end
      end
      
      all_sessions_with_times << { start_time => session }
      current_start = current_start + @duration*60 
      start_time = date_to_time(current_start)
    end

    return all_sessions_with_times
  end



  def print_list()
    puts "\n "
    all_sessions = create_sessions() 
    all_sessions_with_times = add_times_to_sessions(all_sessions)
    
    all_sessions_with_times.each do | session |
      puts session 
    end

    # @students.each do |name|
    
    #   start_time = date_to_time(current_start)

    #   @breaks.each do |key, value|
    #     if key == start_time 
    #       puts start_time.ljust(10) + "----- BREAK ----"
    #       current_start = current_start + value*60
    #       start_time = date_to_time(current_start)
    #     end
    #   end

    #   puts start_time.ljust(10) + name
    #   current_start = current_start + @duration*60  
    # end

    get_break_details()
  end

  def get_break_details()
    puts "\nWant to add a break? Enter time (in 24hr e.g '12:00') : "
    break_time = gets.chomp
    puts "\nHow long should the break be? (mins e.g '20'): "
    break_duration = gets.to_i
    @breaks[break_time] = break_duration
    print_list()
  end

  def get_duration()
    puts "\nHow long do you want the time slots to be? (in mins e.g '20')? : "
    @duration = gets.to_i
  end

  def get_start_time()
    puts "\nWhat is the start time? (in 24hr e.g '12:00') : "
    get_time = gets.chomp
    @start = Time.parse(get_time)
  end

  def get_sessions()
    puts "\nHow many sessions per time slot? : "
    sessions = gets.chomp
    @sessions = sessions.to_i
  end

  def date_to_time(date)
    return date.strftime("%H:%M")
  end

  def add_break(time, duration)
    @breaks = {
      time => duration
    }
  end

end



# ------------

TS = TimeSlotter.new()
TS.create_list()
TS.students = TS.students.shuffle()
puts " "
puts "************************************************"
puts "***************** Time Slotter! ****************"
puts "************************************************"
TS.get_duration()
TS.get_start_time()
TS.get_sessions()
TS.print_list()





