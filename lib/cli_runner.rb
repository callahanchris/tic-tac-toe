require_relative '../config/environment'

module TTT
  class CLIRunner

    include TTT

    attr_accessor :game

    def board
      TTT::BOARD
    end

    def initialize
      title_text
    end

    def intro_text
      puts 'When the cursor appears, enter your move according to the following table:'
      print_legal_moves
      puts "You go first!"
    end

    def title_text
      puts 'Tic Tac Toe'
      puts '-----------'
      puts ' '
    end

    def assign_pieces
      puts 'Do you want to play as X or O?'
      human_piece = gets.chomp.upcase
      if human_piece == 'X'
        self.game = TTT::Game.new(human_piece, 'O')
      elsif human_piece == 'O'
        self.game = TTT::Game.new(human_piece, 'X')
      else
        assign_pieces
      end
    end

    def print_legal_moves
      puts ' UL | UC | UR  '
      puts '---------------'
      puts ' ML | MC | MR  '
      puts '---------------'
      puts ' LL | LC | LR  '
      puts ' '
    end

    def run
      intro_text
      assign_pieces
      pretty_board

      loop do
        # binding.pry
        gameplay
        pretty_board
        if human_wins?
          puts "You win!"
          break
        elsif computer_wins?
          puts "Computer wins!"
          break
        elsif empty_spaces == 0
          puts "Cat got that one ;)"
          break
        end
      end 

      spawn_new_game if new_game?
    end

    def pretty_board
      puts ' ' + board[0][0] + ' | ' + board[0][1] + ' | ' + board[0][2] 
      puts '------------'
      puts ' ' + board[1][0] + ' | ' + board[1][1] + ' | ' + board[1][2] 
      puts '------------'
      puts ' ' + board[2][0] + ' | ' + board[2][1] + ' | ' + board[2][2] 
      puts ' '
    end

    def human_wins?
      check_human = TTT::CheckWinner.new(game.human.piece)
      check_human.winner?
    end

    def computer_wins?
      check_computer = TTT::CheckWinner.new(game.computer.piece)
      check_computer.winner?
    end

    def gameplay
      if empty_spaces % 2 == 0
        puts "Computer's move:"
        game.computer.move
      else
        puts "Your move:"
        game.human.move
      end
    end

    def empty_spaces
      board.flatten.count(' ')
    end

    def new_game?
      puts "Play again?"
      replay = gets.chomp.upcase
      if (replay == 'Y' || replay == 'YES')
        return true
      elsif (replay == 'N' || replay == 'NO')
        puts 'Goodbye!'
        exit
      else
        new_game?
      end
    end

    def spawn_new_game
      TTT::BOARD.each {|row| row.fill(' ')}
      self.run
    end
  end
end