require_relative '../lib/game'

describe Game do
  describe '#play' do
    subject(:game) { Game.new(0, board) }
    let(:board) { instance_double(Board) }

    context 'when game is over' do
      before do
        allow(board).to receive(:over?).and_return(true)
      end

      it 'displays the board then ends' do
        expect(board).to receive(:display).once
        expect(board).to receive(:over?).once
        expect(game).to receive(:print_end).once
        game.play
      end
    end

    context 'when one guess is given then game ends' do
      before do
        allow(board).to receive(:over?).and_return(false, true)
        allow(game).to receive(:puts).with "Player 1 (use the form 'x y'):"
      end

      it 'displays the board, then asks for a guess, then displays again, then ends' do
        expect(board).to receive(:display).twice
        expect(board).to receive(:over?).twice
        expect(game).to receive(:get_move).once
        expect(game).to receive(:print_end).once
        game.play
      end
    end

    context 'when 4 guesses are given then game ends' do
      before do
        allow(board).to receive(:over?).and_return(false, false, false, false, true)
        allow(game).to receive(:puts).with "Player 1 (use the form 'x y'):"
      end

      it 'displays the board, then asks for a guess & displays the board 4 times, then ends' do
        expect(board).to receive(:display).exactly(5).times
        expect(board).to receive(:over?).exactly(5).times
        expect(game).to receive(:get_move).exactly(4).times
        expect(game).to receive(:print_end).once
        game.play
      end
    end
  end

  describe '#get_move' do
    subject(:game) { Game.new(0, board) }
    let(:board) { instance_double(Board) }

    context 'when given valid input' do
      before do
        allow(board).to receive(:get_square).and_return('')
      end

      it 'returns next turn' do
        error_message = "\nInvalid input.\nPlease enter coordinates between 1 and 3 that point to an unoccupied square."
        input = '3 3'
        expect(game).to receive(:validate_input).and_return(input.split)
        expect(board).to receive(:get_square).once
        expect(board).to receive(:mark_square).once
        expect(game).not_to receive(:puts).with error_message
        result = game.get_move(input)
        expect(result).to eq(1)
      end
    end

    context 'when given invalid input' do
      it 'displays error, returns same turn' do
        error_message = "\nInvalid input.\nPlease enter coordinates between 1 and 3 that point to an unoccupied square."
        input = 'a a'
        expect(game).to receive(:validate_input).and_return(nil)
        expect(board).not_to receive(:mark_square)
        expect(game).to receive(:puts).with error_message
        result = game.get_move(input)
        expect(result).to eq(0)
      end
    end

    context 'when given valid input, but square is taken' do
      before do
        allow(board).to receive(:get_square).and_return('X')
      end
      it 'displays error, returns same turn' do
        error_message = "\nInvalid input.\nPlease enter coordinates between 1 and 3 that point to an unoccupied square."
        input = '1 1'
        expect(game).to receive(:validate_input).and_return(input.split)
        expect(board).to receive(:get_square)
        expect(board).not_to receive(:mark_square)
        expect(game).to receive(:puts).with error_message
        result = game.get_move(input)
        expect(result).to eq(0)
      end
    end
  end

  describe '#validate_input'
end
