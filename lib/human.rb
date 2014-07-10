require_relative '../config/environment'

module TTT
  class Human

    include TTT
    extend TTT
    
    attr_accessor :piece, :board, :opponent

    def initialize(piece, opponent)
      self.piece = piece
      self.opponent = opponent
    end

    MOVES = {
      "UL" => {row: 0, col: 0},
      "UC" => {row: 0, col: 1},
      "UR" => {row: 0, col: 2},
      "ML" => {row: 1, col: 0},
      "MC" => {row: 1, col: 1},
      "MR" => {row: 1, col: 2},
      "LL" => {row: 2, col: 0},
      "LC" => {row: 2, col: 1},
      "LR" => {row: 2, col: 2}
    }

    def moves
      MOVES
    end

    def legal_inputs
      MOVES.keys
    end

    def move
      input = gets.chomp.upcase

      if legal_inputs.include?(input) && BOARD[moves[input][:row]][moves[input][:col]] == ' '
        BOARD[moves[input][:row]][moves[input][:col]] = piece
      else
        helper_text
        move
      end
    end

    def helper_text
      puts 'Please move in one of the following spaces: '
      puts ' UL | UC | UR  '
      puts '---------------'
      puts ' ML | MC | MR  '
      puts '---------------'
      puts ' LL | LC | LR  '
      puts ' '
    end
  end
end