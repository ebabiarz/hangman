class Game

  attr_accessor :secret_word
  
  def initialize
    @secret_word = get_random_string
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