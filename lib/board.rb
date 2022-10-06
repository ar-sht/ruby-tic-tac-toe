# frozen_string_literal: true

require_relative 'square'
class Board
  def initialize(squares = Array.new(3) { Array.new(3) { Square.new } })
    @squares = squares
  end

  def mark_square(x_coord, y_coord, player)
    @squares[y_coord][x_coord].mark(player)
  end

  def get_square(x_coord, y_coord)
    @squares[y_coord][x_coord].marking
  end

  def display
    print("+---+---+---+\n")
    @squares.each_with_index { |row, i| print("| #{row[0].marking} | #{row[1].marking} | #{row[2].marking} | #{i + 1}\n+---+---+---+\n") }
    puts('  1   2   3  ')
  end

  def winner?
    diag1 = []
    diag2 = []
    3.times do |i|
      if @squares[i][0].marking == @squares[i][1].marking && @squares[i][1].marking == @squares[i][2].marking &&
         @squares[i][1].marking != ' '
        return [true, squares[i][1].marking]
      elsif @squares[0][i].marking == @squares[1][i].marking && @squares[1][i].marking == @squares[2][i].marking &&
            squares[1][i].marking != ' '
        return [true, squares[1][i].marking]
      end

      diag1 << @squares[i][i].marking
      diag2 << @squares[i][2 - i].marking
    end
    %w[X O].each do |symbol|
      return [true, @squares[1][1].marking] if diag1.all? { |val| val == symbol } || diag2.all? { |val| val == symbol }
    end
    [false, @squares[1][1]]
  end

  def full?
    @squares.all? { |row| row.none? { |square| square.marking == ' ' } }
  end

  def over?
    full? || winner?[0]
  end

  attr_accessor :squares
end
