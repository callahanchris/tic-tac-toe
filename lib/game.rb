require_relative '../config/environment'

module TTT
  class Game
    
    attr_accessor :human, :computer

    def initialize(human_piece, computer_piece)
      self.human = Human.new(human_piece, computer_piece)
      self.computer = Computer.new(computer_piece, human_piece)
    end
  end
end