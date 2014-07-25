require_relative '../config/environment'

class RandomMover < TTT::Computer
  def initialize(piece)
    @piece = piece
  end

  def move
    update_board(rand(3), rand(3))
  end
end
