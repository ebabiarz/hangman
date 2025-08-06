def play_game

  puts "HANGMAN"
  puts "Rules: Guess a letter. If your guess is correct, that letter in the secret word is revealed. If your guess is incorrect, a part of the man is added. If you guess all of the correct letters before each part of the man is added, you win!"

  if load_game? == "y"
    game = load_game
    player = load_player
  else
    game = Game.new(nil, nil, nil, nil, nil)
    player = Player.new(get_name)
  end

  while game.hangman != Game::HANGMAN_CHANGES[6] && game.correct_guesses.include?("_")
    play_turn(game, player)
  end

  if game.correct_guesses.include?("_") == false
    puts game.correct_guesses.join("  ")
    puts "You win!"
    delete_save_on_game_over("game", "player")
  else
    puts game.hangman
    puts "You lose"
    puts "The secret word was..."
    puts game.secret_word.join("")
    delete_save_on_game_over("game", "player")
  end
end

def play_turn(game, player)
  puts game.hangman
  puts game.correct_guesses.join("  ")

  save_game?(game, player)

  puts "#{player.name}, guess a letter"

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

def load_game?
  puts "Would you like to load a saved game?"
  puts "Enter Y to load a saved game"
  puts "Press Enter to start a new game"

  answer = gets.chomp.to_s.downcase

  return answer
end

def load_game
  game_file = File.new './save/game.json', 'r'
  game = Game.from_json(game_file.read)
  game_file.close
  return game
end

def load_player
  player_file = File.new './save/player.json', 'r'
  player = Player.from_json(player_file.read)
  player_file.close
  return player
end

def save_game?(game, player)
  puts "Enter SAVE to save and quit."
  puts "Press ENTER to continue without saving." 
  answer = gets.chomp.to_s.upcase
  if answer == "SAVE"
    save_game(game, player)
  end
end

def save_game(game, player)
  write_to_file(game.to_json, "game")
  write_to_file(player.to_json, "player")
  exit
end

def write_to_file(data, instance)
  file = File.new "./save/#{instance}.json", "w"
  file.puts data
  file.close
end

def delete_save_on_game_over(game_instance, player_instance)
  if File.exist?("./save/#{game_instance}.json")
    File.delete("./save/#{game_instance}.json")
  end

  if File.exist?("./save/#{player_instance}.json")
    File.delete("./save/#{player_instance}.json")
  end
end