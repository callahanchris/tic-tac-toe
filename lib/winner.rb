require_relative '../config/environment'

class Winner < TTT::Computer
  attr_reader :piece, :opponent

  def initialize(piece, opponent)
    @piece = piece
    @opponent = opponent
  end

  def move
    if can_win_horiz?
      horiz_win
    elsif can_win_vert?
      vert_win
    else
      diag_win
    end
  end

  def can_win?
    can_win_horiz? || can_win_vert? || can_win_diag?
  end

  def potential_wins
    [piece, piece, ' '].permutation.to_a.uniq
  end

  def can_win_horiz?
    potential_wins.any? do |pot_win|
      board.include?(pot_win)
    end
  end

  def can_win_vert?
    potential_wins.any? do |pot_win|
      rotated_board.include?(pot_win)
    end
  end

  def can_win_diag?
    potential_wins.any? do |pot_win|
      diagonals.include?(pot_win)
    end
  end

  def horiz_win
    two_in_a_row = potential_wins.detect do |pot_win|
      board.include?(pot_win)
    end

    row = board.index(two_in_a_row)
    col = board[row].index(" ")
    update_board(row, col)
  end

  def vert_win
    two_in_a_row = potential_wins.detect do |pot_win|
      rotated_board.include?(pot_win)
    end

    col = rotated_board.index(two_in_a_row)
    row = rotated_board[col].reverse.index(" ")
    update_board(row, col)
  end

  def diag_win
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
end
