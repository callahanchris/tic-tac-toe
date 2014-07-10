require_relative '../config/environment'

class Opener < TTT::Computer
  attr_reader :piece

  def initialize(piece)
    @piece = piece
  end

  def move
    center_open? ? center_move : corner_move
  end

  def center_square
    board[1][1]
  end

  def center_open?
    center_square == ' '
  end

  def center_move
    update_board(1, 1)
  end

  def corners
    [[0, 0], [0, 2], [2, 0], [2, 2]]
  end

  def corner_move
    row, col = corners.sample
    update_board(row, col)
  end
end
