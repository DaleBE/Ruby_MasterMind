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
      puts 'Choose a color: ( red, yellow, green, blue, orange, or purple )'
      choice = gets.chomp!
      choice
    end
  end
end

class CheckGuess
  def compare_codes(maker, breaker)
    puts ''
    puts 'Let us see how close you are...'
    display_results(check_right_place(maker, breaker), check_right_color(maker, breaker))
  end

  def check_right_place(maker, breaker)
    right_place = maker.map { |pos, value| value == breaker[pos] }
    right_place.tally
  end

  def check_right_color(maker, breaker)
    new_arr = maker.values.intersection(breaker.values)
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

class GamePlay

  def initialize(code_maker, code_breaker, check_guess)
    @code_maker = code_maker
    @code_breaker = code_breaker
    @check_guess = check_guess
    @maker_code = @code_maker.color_code
    @breaker_code = @code_breaker.color_code
  end

  def play_game
    puts 'Lets play MasterMind! You will have upto 12 chances to guess the secret color code.'
    puts ''

    code_maker_choose
    # puts @code_maker.color_code

    play_round
  end

  def play_round
    round = 1

    while round <= 12
      puts ''
      puts "Round: #{round}"

      code_breaker_choose
      @check_guess.compare_codes(@maker_code, @breaker_code)

      break if @code_maker.color_code == @code_breaker.color_code

      round += 1
    end

    puts "GAME OVER .. The secret code was: #{@maker_code.values.join(' ')}"
  end

  def code_maker_choose
    @code_maker.generate_color_sequence
    puts 'The computer has chosen a color code.'
    puts ''
  end

  def code_breaker_choose
    puts 'Code Breaker, please choose a color code.'
    @code_breaker.generate_color_sequence
    puts "You have chosen: #{@breaker_code.values.join(' ')}"
  end
end

new_game = GamePlay.new(Computer.new, Player.new, CheckGuess.new)

new_game.play_game

