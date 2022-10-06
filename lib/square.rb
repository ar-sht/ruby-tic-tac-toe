# frozen_string_literal: true

SYMBOLS = { 0 => 'X', 1 => 'O' }.freeze
class Square
  def initialize(marked = false, player = -1)
    @marked = marked
    @player = player
  end

  def mark(player)
    @marked = true
    @player = player
  end

  def marking
    if @marked
      SYMBOLS[@player]
    else
      ' '
    end
  end
end
