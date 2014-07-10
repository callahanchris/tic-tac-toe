require_relative '../config/environment'

module TTT
  class Computer
    include Playable
    include TTT

    attr_accessor :piece, :board, :opponent

    # def initialize(piece, opponent)
    #   self.piece = piece
    #   self.opponent = opponent
    # end

    def board
      TTT::BOARD
    end
    
    def update_board(row, col)
      TTT::BOARD[row][col] = piece
    end

    def move
      if empty_spaces > 7
        opening_move
      elsif can_win?
        winning_move
      elsif can_block?
        blocking_move
      else
        random_move
      end
    end

    def empty_spaces
      board.flatten.count(' ')
    end

    def rotated_board
      board.transpose.map(&:reverse)
    end

    def center_square
      board[1][1]
    end

    def center_open?
      center_square == ' '
    end

    def corners
      [[0, 0], [0, 2], [2, 0], [2, 2]]
    end

    def corner_move
      row, col = corners.sample
      update_board(row, col)
    end

    def opening_move
      center_open? ? update_board(1, 1) : corner_move
    end

    def comp_wins
      [piece, piece, ' '].permutation.to_a.uniq
    end

    def human_wins
      [opponent, opponent, ' '].permutation.to_a.uniq
    end

    def can_win_horiz?(potential_wins = comp_wins)
      # possibly refactor into verticals
      potential_wins.any? do |pot_win|
        board.include?(pot_win) || rotated_board.include?(pot_win)
      end
    end

    def diagonals
      # [[0, 0], [1, 1], [2, 2]] ? ? ? 
      [
        [board[0][0], board[1][1], board[2][2]],
        [rotated_board[0][0], rotated_board[1][1], rotated_board[2][2]]
      ]
    end

    def can_win_diag?(potential_wins = comp_wins)
      potential_wins.any? do |pot_win|
        diagonals.include?(pot_win)
      end
    end

    def can_win?(potential_wins = comp_wins)
      can_win_horiz?(human_wins) || can_win_diag?(human_wins)
    end

    def winning_move
      can_win_horiz?(comp_wins) ? horiz_win(comp_wins) : diag_win(comp_wins)
    end

    def blocking_move
      can_win_horiz?(human_wins) ? horiz_win(human_wins) : diag_win(human_wins)
    end

    def horiz_win(potential_wins = comp_wins)
      two_in_a_row = potential_wins.detect do |pot_win|
        board.include?(pot_win)
      end

      if two_in_a_row.nil?
        two_in_a_row = potential_wins.detect do |pot_win|
          rotated_board.include?(pot_win)
        end

        row = rotated_board.index(two_in_a_row)
        col = rotated_board[row].index(" ")
        update_board(row, col)
      else
        row = board.index(two_in_a_row)
        col = board[row].index(" ")
        update_board(row, col)
      end
    end

    def diag_win(potential_wins = comp_wins)
      if potential_wins.include?(diagonals[0])
        coor = diagonals[0].index(" ")
        update_board(coor, coor)
      else
        coor = diagonals[1].index(" ")
        if coor == 0
          update_board(2, 0)
        elsif coor == 1
          update_board(1, 1)
        else
          update_board(0, 2)
        end
      end
    end

    def can_block?
      can_win?(human_wins)
    end

    def blocking_move
      can_win_horiz?(human_wins) ? horiz_win(human_wins) : diag_win(human_wins)
    end
    
    def random_move
      row = rand(3)
      col = rand(3)
      
      if board[row][col] == ' '
        update_board(row, col)
      else
        random_move
      end
    end
  end
end