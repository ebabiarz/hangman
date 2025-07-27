def play_game
  game = Game.new
  puts "HANGMAN"
  puts "Rules: Guess a letter. If your guess is correct, that letter in the secret word is revealed. If your guess is incorrect, a part of the man is added. If you guess all of the correct letters before each part of the man is added, you win!"
  player = Player.new(get_name)

  while game.hangman != Game::HANGMAN_CHANGES[6] && game.correct_guesses.include?("_")
    play_turn(game, player)
  end

  if game.correct_guesses.include?("_") == false
    puts game.correct_guesses.join("  ")
    puts "You win!"
  else
    puts game.hangman
    puts "You lose"
  end
end

def play_turn(game, player)
  puts game.hangman
  puts game.correct_guesses.join("  ")
  puts "#{player.name}, Guess a letter"

  game.get_guess
  if game.check_correct_guess == "incorrect"
    game.wrong_guesses += 1
    game.hangman = Game::HANGMAN_CHANGES[game.wrong_guesses]
  else
    game.check_correct_guess.each_index do |index|
      game.correct_guesses[game.check_correct_guess[index]] = game.guesses.last
    end
  end
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