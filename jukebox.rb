# Author: Manuel Neuhauser
# Date : 9/27/2013
# Email: manuel.neuhauser@flatironschool.com

# Download Gist: https://gist.github.com/scottcreynolds/e6534b284373efe0ba6e/download
# Build a Jukebox

# create a file jukebox.rb

# When that program is run, it should introduce itself
# to the user and accept input from the user using the gets command.

# The jukebox should respond to 4 commands, help, play, list and exit.

# The help command should output instructions for the user
# on how to use the jukebox.

# The list command should output a list of songs that the
# user can play.

# the play command should accept a song, either by number/index
# or name. Once the user has indicated which song they want to
# play, the jukebox should output 'Playing The Phoenix - 1901'
# or whatever song name is important.

# if the user types in exit, the jukebox should say goodbye
# and the program should shut down.

# Think about the following things

# How to keep the program running until the exit command is
# executed (Hint: Loop maybe? Loop upon a condition)

# How to normalize the user's input so LIST and list are the
# same. (Hint, maybe downcase and strip it)

# How to give the songs an "index" so that when you list them
# out, you can refer to them by position so the user can just
# type play 1 and then you find the first song. (Hint, check
# out a method called each_with_index)

songs = [
  "The Phoenix - 1901",
  "Tokyo Police Club - Wait Up",
  "Sufjan Stevens - Too Much",
  "The Naked and the Famous - Young Blood",
  "(Far From) Home - Tiga",
  "The Cults - Abducted",
  "The Phoenix - Consolation Prizes"
]

$banner_message = "Welcome to Jukebox d(-_-)b"
$exit_message   = "Thanks for using Jukebox. Good-bye!"  
$window_width   = 80
$prompt         = "#> "



def help
  puts (["The most commonly used Jukebox commands are:",
         "   play <song|index>  Play specified song",
         "   list               List all songs that can be played",
         "   help               Display the list of accepted commands",
         "   exit               Exit the jukebox application"]).join("\n")
end

def play(selection, songs)
  case selection 
  when ""
    puts "Please make a song selection."
  when /[0-9]+/
    play_song_by_index(selection, songs)
  else 
    play_song_by_string(selection, songs)
  end
end

def play_song_by_index(selection, songs)
  song = songs[selection.to_i-1]
  if song
    play_song(song)
  else
    puts "Wat! This index doesn't exist."
  end
end

def play_song_by_string(selection, songs)
  matching_songs = find_matching_songs(selection, songs)
  case matching_songs.length
  when 1 then play_song matching_songs[0]
  when 0 then puts "No matching songs found."
  else list_matching_songs(matching_songs)
  end
end

def find_matching_songs(selection, songs)
  index = 0
  songs.map do |song|
    index += 1
    song_downcase = song.downcase
    song_with_index(song, index) unless song_downcase[selection.downcase] == nil
  end.compact
end

def list_matching_songs(matching_songs)
  puts "Hold on just a second. There are multiple songs matching your selection."
  matching_songs.each_with_index do |song|
    puts song
  end
end

def play_song(song)
  puts ""
  puts "*** [▶] Now playing: #{song} ***".center($window_width)
  puts ""
end

def list(songs)
  songs.each_with_index do |song, index|
    puts song_with_index(song, index)
  end
end

def song_with_index(song, index)
  "< #{index+1} >  #{song}"
end



puts "#" * $window_width
puts $banner_message.center($window_width) 
puts "#" * $window_width


loop do
  puts ""
  print $prompt
  user_input = gets.chomp

  args_array = user_input.split
  command = args_array.shift.downcase
  args = args_array.join(" ")

  case command
    when "help" then help()
    when "play" then play(args, songs)
    when "list" then list(songs)
    when "exit" then break
    when nil
    else
      puts "Command not found. Type 'help' for more information."
  end
end


puts "#" * $window_width
puts $exit_message.center($window_width) 
puts "#" * $window_width





