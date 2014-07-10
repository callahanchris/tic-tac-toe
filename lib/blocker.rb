require_relative '../config/environment'

class Blocker < TTT::Computer::Winner
  def move
    if can_win_horiz?
      horiz_win
    elsif can_win_vert?
      vert_win
    else
      diag_win
    end
  end

  def potential_wins
    [opponent, opponent, ' '].permutation.to_a.uniq
  end

  def can_block?
    can_win?
  end
end
