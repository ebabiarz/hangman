def play_game
  game = Game.new
  puts "HANGMAN"
  puts "Rules: Guess a letter. If your guess is correct, that letter in the secret word is revealed. If your guess is incorrect, a part of the man is added. If you guess all of the correct letters before each part of the man is added, you win!"
  player = Player.new(get_name)


end

def play_turn(game, player)
  puts game.hangman
  puts game.correct_guesses.join("  ")
  puts "#{player.name}, Guess a letter"

  
end

def get_name
  puts "Please enter your name"
  name = gets.chomp.to_s
  
  if check_name(name) == name
    return name
  end
end

def check_name(name)
  puts "#{name} - Is this the correct name?"
  puts "Enter Y or N"

  answer = gets.chomp.to_s.downcase
  if answer == "n"
    get_name
  elsif answer == "y"
    return name
  else
    puts "Not a valid response"
    check_name(name)
  end
end