class Player
  
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def to_json
    JSON.dump ({
      :name => @name,
    })
  end

  def self.from_json(string)
    data = JSON.load string
    self.new(data['name'])
  end
end