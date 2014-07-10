require_relative '../config/environment'

module Playable
  def initialize(piece, opponent)
    self.piece = piece
    self.opponent = opponent
  end

  def potential_wins
    [piece, piece, ' '].permutation.to_a.uniq
  end

  def opponent_wins
    [opponent, opponent, ' '].permutation.to_a.uniq
  end

  def can_win_horiz?(poss_wins = potential_wins)
    # possibly refactor into verticals
    poss_wins.any? do |pot_win|
      board.include?(pot_win) || rotated_board.include?(pot_win)
    end
  end

  def diagonals
    [
      [board[0][0], board[1][1], board[2][2]],
      [rotated_board[0][0], rotated_board[1][1], rotated_board[2][2]]
    ]
  end

  def can_win_diag?(poss_wins = potential_wins)
    poss_wins.any? do |pot_win|
      diagonals.include?(pot_win)
    end
  end

  def can_win?
    can_win_horiz? || can_win_diag?
  end

  def can_opponent_win?
    can_win_horiz? || can_win_diag?
  end
end