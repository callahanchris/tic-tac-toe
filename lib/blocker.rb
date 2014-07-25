require_relative '../config/environment'

class Blocker < Winner
  def potential_wins
    [opponent, opponent, ' '].permutation.to_a.uniq
  end

  def can_block?
    can_win?
  end
end
