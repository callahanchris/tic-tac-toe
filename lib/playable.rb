require_relative '../config/environment'

module Playable
  def initialize(piece, opponent)
    self.piece = piece
    self.opponent = opponent
  end

end