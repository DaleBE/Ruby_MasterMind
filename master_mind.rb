class Computer
  attr_reader :computers_code

  def initialize(computers_code)
    @computers_code = computers_code
  end
end

class Player
  attr_accessor :players_code

  def initialize(players_code)
    @players_code = players_code
  end
end

def generate_color_sequence
  colors = %w[red green blue orange purple yellow]
  new_color_array = []

  4.times do
    index = rand(0..5)
    new_color_array.unshift(colors[index])
  end
  new_color_array
end

def choose_sequence
  players_code = []

  4.times do
    puts 'Player, please choose a color: ( red, yellow, green, blue, orange, or purple )'
    choice = gets.chomp!
    players_code.unshift(choice)
  end
  players_code
end

computer = Computer.new(generate_color_sequence)
p computer.computers_code

player = Player.new(choose_sequence)
p player.players_code
