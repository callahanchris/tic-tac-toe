require_relative '../config/environment'

module TTT
  class CheckWinner

    attr_accessor :winner, :piece
    attr_reader :board

    def initialize(piece)
      self.piece = piece
    end

    def board
      TTT::BOARD
    end

    def wins
      [piece, piece, piece]
    end

    def rotated_board
      # board = BOARD
      board.transpose.map(&:reverse)
    end

    def diag_wins?
      wins == [board[0][0], board[1][1], board[2][2]] ||
        wins == [rotated_board[0][0], rotated_board[1][1], rotated_board[2][2]]
    end

    def winner?
      board.include?(wins) || rotated_board.include?(wins) || diag_wins?
    end

    def empty_board?
      board.any?{|t| t == ' ' }
    end

    def game_over?
      winner? || empty_board?
    end

    def winner
      self.winner = piece if winner?
    end
  end
end