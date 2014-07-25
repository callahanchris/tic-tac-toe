require_relative '../config/environment'

module TTT

  BOARD = [[' ', ' ', ' '],
           [' ', ' ', ' '],
           [' ', ' ', ' ']]

  def print_legal_moves
    puts ' UL | UC | UR  '
    puts '---------------'
    puts ' ML | MC | MR  '
    puts '---------------'
    puts ' LL | LC | LR  '
    puts ' '
  end

end