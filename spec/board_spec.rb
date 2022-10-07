require_relative '../lib/board'

describe Board do
  describe '#over?' do
    subject(:board) { Board.new }

    context 'when game is won by one player' do
      it 'returns true' do
        won_position = [['X', '', 'O'], ['', 'X', ''], ['O', '', 'X']]
        result = board.over?(won_position)
        expect(result).to be true
      end
    end

    context 'when game is not won' do
      it 'sends query to #full?' do
        not_won_position = [['', '', ''], ['', '', ''], ['', '', '']]
        expect(board).to receive(:full?).with(not_won_position)
        board.over?(not_won_position)
      end
    end
  end
  
  describe '#full?' do
    subject(:board) { Board.new }
    
    context 'when game board is full' do
      it 'returns true' do
        full_position = [%w[X X O], %w[O O X], %w[X X O]]
        result = board.full?(full_position)
        expect(result).to be true
      end
    end

    context 'when game board is not full' do
      it 'returns false' do
        not_full_position = [['O', '', 'X'], ['', 'X', ''], ['O', '', 'X']]
        result = board.full?(not_full_position)
        expect(result).to be false
      end
    end
  end

  describe '#mark_square' do
    subject(:board) { Board.new }

    context 'when given coordinates and value' do
      it 'updates proper square to new value' do
        expect { board.mark_square(1, 1, 0) }.to change{ board.instance_variable_get(:@squares)[1][1] }.to('X')
      end
    end
  end
  
  describe '#get_square' do
    subject(:board) { Board.new }

    context 'when given coordinates' do
      it 'returns proper square value' do
        squares = [%w[X X O], %w[O O X], %w[X X O]]
        expect(board.get_square(1, 1, squares)).to eq('O')
      end
    end
  end
end
