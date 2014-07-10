require_relative '../config/environment'

module TTT
  class Computer
    include TTT

    attr_reader :piece, :board, :opponent, :opener, 
                :winner, :blocker, :random_mover

    def initialize(piece, opponent)
      @piece = piece
      @opponent = opponent
      @opener = Opener.new(piece)
      @winner = Winner.new(piece, opponent)
      @blocker = Blocker.new(piece, opponent)
      @random_mover = RandomMover.new(piece)
    end

    def board
      TTT::BOARD
    end
    
    def update_board(row, col)
      TTT::BOARD[row][col] = piece if TTT::BOARD[row][col] == ' '
    end

    def move
      if empty_spaces > 7
        opener.move
      elsif winner.can_win?
        winner.move
      elsif blocker.can_block?
        blocker.move
      else
        random_mover.move
      end
    end

    def empty_spaces
      board.flatten.count(' ')
    end

    def rotated_board
      board.transpose.map(&:reverse)
    end

    def diagonals
      [
        [board[0][0], board[1][1], board[2][2]],
        [rotated_board[0][0], rotated_board[1][1], rotated_board[2][2]]
      ]
    end
  end
end
