class Game

  VALID_GUESSES = ("A".."Z").to_a

  attr_accessor :secret_word, :guesses, :wrong_guesses, :correct_guesses
  
  def initialize
    @secret_word = get_random_string.upcase.split("")
    @guesses = Array.new
    @wrong_guesses = 0
    @correct_guesses = initialize_correct_guesses
  end

  def initialize_correct_guesses
    secret_word_length = Array.new
    (self.secret_word.length).times {|char| secret_word_length.push("_")}

    return secret_word_length
  end

  def get_guess(player)
    guess = gets.chomp.to_s.upcase
    if check_duplicate(guess) == true
      puts "You have already made that guess. Try again."
      get_guess(player)
    elsif check_valid_guess(guess) == false
      puts "That is not a valid guess. Try again."
      get_guess(player)
    else
      self.guesses.push(guess)
    end
  end

  def check_valid_guess(guess)
    if guess.length == 1 && VALID_GUESSES.include?(guess)
      return true
    else
      return false
    end
  end

  def check_duplicate(guess)
    return self.guesses.include?(guess)
  end

  def get_random_string
    file = File.open("../google-10000-english-no-swears.txt")
    file.rewind
    array = Array.new
    
    while line = file.gets do
      if line.length >= 6 && line.length <= 13
        array.push(line.strip)
      end
    end

    num = Random.rand(array.length)
    word = array[num]

    return word
  end
end