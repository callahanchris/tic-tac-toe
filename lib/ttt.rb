require_relative '../config/environment'

module TTT

  BOARD = [[' ', ' ', ' '],
           [' ', ' ', ' '],
           [' ', ' ', ' ']]

end

require_relative 'computer'
require_relative 'opener'
require_relative 'winner'
require_relative 'blocker'
require_relative 'random_mover'
require_relative 'check_winner'
require_relative 'game'
require_relative 'human'
require_relative 'cli_runner'