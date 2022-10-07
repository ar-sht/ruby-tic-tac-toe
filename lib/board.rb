# frozen_string_literal: true
class Board

  WINNERS = [[0, 1, 2], [3, 4, 5], [6, 7, 8],
             [0, 3, 6], [1, 4, 7], [2, 5, 8],
             [0, 4, 8], [2, 4, 6]].freeze
  def initialize(squares = Array.new(3) { Array.new(3) { '' } })
    @squares = squares
  end

  def over?(board = @squares)
    flat_board = board.flatten
    WINNERS.any? do |winner|
      matcher = [flat_board[winner[0]], flat_board[winner[1]], flat_board[winner[2]]].uniq!

      return true if !matcher.nil? && matcher.length == 1 && matcher != ['']
    end

    full?(board)
  end

  def full?(board = @squares)
    board.all? { |row| row.none? { |square| square == '' } }
  end

  def mark_square(x_coord, y_coord, player)
    @squares[2 - y_coord][x_coord] = player.zero? ? 'X' : 'O'
  end

  def get_square(x_coord, y_coord, board = @squares)
    board[2 - y_coord][x_coord]
  end

  def display
    print("  +---+---+---+\n")
    @squares.each_with_index { |row, i| print("#{3 - i} | #{row[0].empty? ? ' ' : row[0]} | #{row[1].empty? ? ' ' : row[1]} | #{row[2].empty? ? ' ' : row[2]} |\n  +---+---+---+\n") }
    puts('    1   2   3  ')
  end
end
