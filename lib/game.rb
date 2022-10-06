# frozen_string_literal: true
require_relative 'board'
require_relative 'square'

class Game
  def initialize(turn = 0, board = Board.new)
    @turn = turn
    @board = board
  end

  def play
    p @board
    @board.display
    until @board.over?
      get_move
      @board.display
    end
    print_end
  end

  def get_move
    puts "Player #{@turn + 1} (use the form 'x y'):"
    coords = gets.chomp.strip.split
    x = coords[0].to_i - 1
    y = coords[1].to_i - 1
    unless x.between?(0, 2) && y.between?(0, 2) && @board.get_square(x, y) == ' '
      puts "\nInvalid input.\nPlease enter coordinates between 1 and 3 that point to an unoccupied square."
      return @turn
    end
    @board.mark_square(x, y, @turn)
    @turn = (@turn + 1) % 2
  end

  def print_end
    if @board.winner?[0]
      puts "And the winner is...\n#{@board.winner?[1]}!"
    else
      puts "Cat's game, there is no winner."
    end
  end
end

test_game = Game.new
test_game.play