class Computer
  attr_reader :computers_code

  def initialize
    @computers_code = generate_color_sequence
  end

  def generate_color_sequence
    colors = %w[red green blue orange purple yellow]
    new_color_hash = { first: '', second: '', third: '', fourth: '' }
    new_color_hash.transform_values! { colors[rand(0..5)] }
  end
end

class Player
  attr_accessor :players_code

  def initialize
    @players_code = { first: '', second: '', third: '', fourth: '' }
  end

  def choose_sequence
    @players_code.transform_values! do
      puts 'Player, please choose a color: ( red, yellow, green, blue, orange, or purple )'
      choice = gets.chomp!
      choice
    end
  end
end

def check_right_place(hash1, hash2)
  right_place = hash1.map { |pos, value| value == hash2[pos] }
  right_place.tally
end

def check_right_color(hash1, hash2)
  new_arr = hash1.values.intersection(hash2.values)
  new_arr.length
end

def display_results(result1, result2)
  if result1[true] == 4
    return puts 'Congrats! You guessed the secret code.'
  elsif result1.key?(true)
    puts "Correct colors in correct places: #{result1[true]}"
  end

  puts result2.positive? ? "Correct colors: #{result2}" : 'No correct colors'
end


computer = Computer.new
p computer.computers_code

player = Player.new
player.choose_sequence
p player.players_code
