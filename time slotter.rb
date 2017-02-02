require 'time'

students = %w( 

)

def print_list(names_list, start, duration, break_time_1 = nil, break_1_duration = nil, break_time_2 = nil, break_time_3 = nil)

  names_list.each do |name|

    start_time = date_to_time(start)

    if (break_time_1 == start_time || break_time_2 == start_time || break_time_3 == start_time)
      puts "#{start_time}: BREAK"
      start = start + break_1_duration*60  
      start_time = date_to_time(start)
      puts "#{start_time}: #{name}"

    else
      puts "#{start_time}: #{name}"
    end

    start = start + duration*60  

  end
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



# ------------

students = students.shuffle()

puts "*** Time Slotter! ***"
duration = get_duration()
start_date_time = get_start_time()
start_time = date_to_time(start_date_time)

puts `clear`

print_list(students, start_date_time, duration)
print "Want to add a break? Enter time (in 24hr) : "
break_1 = gets.chomp
print "How long should the break be? (mins): "
break_1_duration = gets.to_i
puts `clear`
print_list(students, start_date_time, duration, break_1, break_1_duration)

print "Want to add another break? Enter time (in 24hr) : "
break_2 = gets.chomp
puts `clear`
print_list(students, start_date_time, duration, break_1, break_1_duration, break_2)

print "Want to add another break? Enter time (in 24hr) : "
break_3 = gets.chomp
puts `clear`
print_list(students, start_date_time, duration, break_1, break_1_duration, break_2, break_3)
puts "I think that's quite enough breaks"





# puts `clear`

# start_date_time = Time.parse(get_time) 
# start_time = start_date_time.strftime("%H:%M")

# students.each do |student|
#   if break_time == start_date_time 
#     puts "#{start_time}: BREAK"
#   else 
#     puts "#{start_time}: #{student}"
#   end
#   start_date_time = start_date_time + duration*60  
#   start_time = start_date_time.strftime("%H:%M")
# end
