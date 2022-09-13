# frozen_string_literal: true

require './square'
class Board
  def initialize
    @squares = Array.new(3) { Array.new(3) }
    @squares.each { |row| row.map! { |_| Square.new(false, -1) } }
  end

  def mark_square(x_coord, y_coord, player)
    @squares[x_coord][y_coord].mark(player)
  end

  def get_square(x_coord, y_coord)
    @squares[x_coord][y_coord].marking
  end

  def display
    print("+---+---+---+\n")
    @squares.each { |row| print("| #{row[0].marking} | #{row[1].marking} | #{row[2].marking} |\n+---+---+---+\n") }
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

      diag1 << @squares[i][i]
      diag2 << @squares[i][2 - i]
    end
    [diag1.all? { |val| %w[X O].include?(val) } || diag2.all? { |val| %w[X O].include?(val) }, @squares[1][1].marking]
  end

  def full?
    @squares.all? { |row| row.none? { |square| square.marking == ' ' } }
  end

  def over?
    full? || winner?[0]
  end

  attr_accessor :squares
end
