class Computer
  attr_reader :color_code

  def initialize
    @color_code = { first: '', second: '', third: '', fourth: '' }
  end

  def generate_color_sequence
    colors = %w[red green blue orange purple yellow]
    @color_code.transform_values! { colors[rand(0..5)] }
  end
end

class Player
  attr_reader :color_code

  def initialize
    @color_code = { first: '', second: '', third: '', fourth: '' }
  end

  def generate_color_sequence
    @color_code.transform_values! do
      puts 'Player, please choose a color: ( red, yellow, green, blue, orange, or purple )'
      choice = gets.chomp!
      choice
    end
  end
end

class GamePlay

  def initialize(code_maker, code_breaker)
    @code_maker = code_maker
    @code_breaker = code_breaker
  end

  def play_game
    round = 1
    puts 'Lets play MasterMind! You will have upto 12 chances to guess the secret color code.'

    code_maker_choose
    puts @code_maker.color_code

    while round <= 12 do
      puts "Round: #{round}"
      code_breaker_choose
      compare_codes

      if @code_maker.color_code == @code_breaker.color_code
        puts 'Code Breaker you have won!'
        break
      end
      round += 1
    end
  end
  
  def code_maker_choose
    @code_maker.generate_color_sequence
    puts 'The computer has chosen a color code.'
  end

  def code_breaker_choose
    puts 'Code Breaker, please choose a color code.'
    @code_breaker.generate_color_sequence
    puts "You have chosen: #{@code_breaker.color_code.values.join(' ')}"
  end

  def compare_codes
    puts 'Let us see how close you are...'
    display_results(check_right_place(@code_maker.color_code, @code_breaker.color_code), check_right_color(@code_maker.color_code, @code_breaker.color_code))
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
end

new_game = GamePlay.new(Computer.new, Player.new)

new_game.play_game

