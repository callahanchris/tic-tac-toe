require_relative '../config/environment'

module TTT

  BOARD = [[' ', ' ', ' '],
           [' ', ' ', ' '],
           [' ', ' ', ' ']]

  # MOVES = {
  #   "UL" => board[0][0],
  #   "UC" => board[0][1],
  #   "UR" => board[0][2],
  #   "ML" => board[1][0],
  #   "MC" => board[1][1],
  #   "MR" => board[1][2],
  #   "LL" => board[2][0],
  #   "LC" => board[2][1],
  #   "LR" => board[2][2]
  # }



end

require_relative 'computer'
require_relative 'check_winner'
require_relative 'game'
require_relative 'human'
require_relative 'cli_runner'