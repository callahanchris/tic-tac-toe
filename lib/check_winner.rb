require_relative '../config/environment'

module TTT
  class CheckWinner
    attr_reader :board, :winner, :piece

    def initialize(piece)
      @piece = piece
    end

    def board
      TTT::BOARD
    end

    def wins
      [piece, piece, piece]
    end

    def rotated_board
      board.transpose.map(&:reverse)
    end

    def diag_wins?
      wins == [board[0][0], board[1][1], board[2][2]] ||
        wins == [rotated_board[0][0], rotated_board[1][1], rotated_board[2][2]]
    end

    def winner?
      board.include?(wins) || rotated_board.include?(wins) || diag_wins?
    end
  end
end