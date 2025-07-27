require './lib/player'
require './lib/game'
require './lib/play-game'

puts "Please enter your name"
player = Player.new(gets.chomp.to_s)