class Game
  def initialize
    @secret_number_range = 1..10
    @secret_number = rand(@secret_number_range)
    @guesses_allowed = 3
    @tries = 0
  end

  def start
    display_welcome_message

    while @tries < @guesses_allowed
      @tries += 1
      puts "Enter your guess, #{@secret_number_range.min}-#{@secret_number_range.max}"
      @guess = gets.strip.to_i

      if @guess < @secret_number
        display_guesses_left('low', 'higher')
      elsif @guess > @secret_number
        display_guesses_left('high', 'lower')
      else
        puts "You won!"
        exit      
      end
    end
  end

  private

  def display_welcome_message
    puts "Welcome to the secret number game"
    puts "What's your name?"
    @name = gets.strip
    puts "Welcome #{@name}, you have #{@guesses_allowed} tries to guess the secret number"
  end

  def display_guesses_left(this_turn, next_turn)
    puts "You guessed too #{this_turn}, guess #{next_turn}"
  end
end

my_secret_number_game = Game.new

require 'pry'
binding.pry

my_secret_number_game.start

