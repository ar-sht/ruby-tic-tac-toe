# frozen_string_literal: true
require './board'
require './square'

turn = 0
def get_move(cur_board, turn)
  puts "Player #{turn + 1} (use the form 'x y'):"
  coords = gets.chomp.split
  x = coords[0].to_i - 1
  y = coords[1].to_i - 1
  if x.between?(0, 2) && y.between?(0, 2) && cur_board.get_square(x, y) == ' '
    cur_board.mark_square(x, y, turn)
    (turn + 1) % 2
  else
    puts("#{'* ' * 40}\nInvalidInput.\nPlease enter coordinates between 1 and 3 that point to an unoccupied square
#{'* ' * 40}\n")
    turn
  end
end

board = Board.new
board.display

until board.over?
  turn = get_move(board, turn)
  board.display
end
if board.winner?[0]
  puts "And the winner is...\n#{board.winner?[1]}!"
else
  puts "Cat's game, there is no winner."
end
