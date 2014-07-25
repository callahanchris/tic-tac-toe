require_relative '../config/environment'

module TTT
  class Game
    attr_accessor :human, :computer
    def initialize(human_piece, computer_piece)
      @human = Human.new(human_piece, computer_piece)
      @computer = Computer.new(computer_piece, human_piece)
    end
  end
end