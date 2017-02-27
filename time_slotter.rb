require 'time'

class TimeSlotter

  attr_accessor :start, :duration, :breaks, :students

  def initialize()
    @start = nil
    @duration = nil
    @breaks = {}
    @students = nil
  end

  def create_list
    file = File.open("list_of_names.txt")
    names = file.readlines { |line| names << line }
    @students = names
  end

  def print_list()
    puts "\n "
    format = "%-8s %s"
    current_start = @start

    @students.each do |name|

      start_time = date_to_time(current_start)

      @breaks.each do |key, value|
        if key == start_time 
          puts format % [start_time, '----- BREAK ----']
          current_start = current_start + value*60
          start_time = date_to_time(current_start)
        end
      end

      puts format % [start_time, name]
      current_start = current_start + @duration*60  
    end

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
    puts "\nWhat do you want as the start time? (in 24hr e.g '12:00') : "
    get_time = gets.chomp
    @start = Time.parse(get_time)
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
TS.print_list()



# format = "%-10s %-20s %-20s %s"
# puts format % ['Time', 'Instructor1', 'Instructor2', 'Instructor2']



