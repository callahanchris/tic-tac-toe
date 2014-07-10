require_relative '../config/environment'

module TTT
  class Computer
    include TTT

    attr_reader :piece, :board, :opponent, :opener, 
                :winner, :blocker, :random_mover

    def initialize(piece, opponent)
      @piece = piece
      @opponent = opponent
      @opener = Opener.new(piece)
      @winner = Winner.new(piece, opponent)
      @blocker = Blocker.new(piece, opponent)
      @random_mover = RandomMover.new(piece)
    end

    def board
      TTT::BOARD
    end
    
    def update_board(row, col)
      TTT::BOARD[row][col] = piece if TTT::BOARD[row][col] == ' '
    end

    def move
      if empty_spaces > 7
        opener.move
      elsif winner.can_win?
        winner.move
      elsif blocker.can_block?
        blocker.move
      else
        random_mover.move
      end
    end

    def empty_spaces
      board.flatten.count(' ')
    end

    def rotated_board
      board.transpose.map(&:reverse)
    end

    def diagonals
      [
        [board[0][0], board[1][1], board[2][2]],
        [rotated_board[0][0], rotated_board[1][1], rotated_board[2][2]]
      ]
    end
  end
end

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

class RandomMover < TTT::Computer
  attr_reader :piece

  def initialize(piece)
    @piece = piece
  end

  def move
    update_board(rand(3), rand(3))
  end
end

class Winner < TTT::Computer
  attr_reader :piece, :opponent

  def initialize(piece, opponent)
    @piece = piece
    @opponent = opponent
  end

  def move
    if can_win_horiz?
      horiz_win
    elsif can_win_vert?
      vert_win
    else
      diag_win
    end
  end

  def can_win?
    can_win_horiz? || can_win_vert? || can_win_diag?
  end

  def potential_wins
    [piece, piece, ' '].permutation.to_a.uniq
  end

  def can_win_horiz?
    potential_wins.any? do |pot_win|
      board.include?(pot_win)
    end
  end

  def can_win_vert?
    potential_wins.any? do |pot_win|
      rotated_board.include?(pot_win)
    end
  end

  def can_win_diag?
    potential_wins.any? do |pot_win|
      diagonals.include?(pot_win)
    end
  end

  def horiz_win
    two_in_a_row = potential_wins.detect do |pot_win|
      board.include?(pot_win)
    end

    row = board.index(two_in_a_row)
    col = board[row].index(" ")
    update_board(row, col)
  end

  def vert_win
    two_in_a_row = potential_wins.detect do |pot_win|
      rotated_board.include?(pot_win)
    end

    col = rotated_board.index(two_in_a_row)
    row = rotated_board[col].reverse.index(" ")
    update_board(row, col)
  end

  def diag_win
    if potential_wins.include?(diagonals[0])
      coor = diagonals[0].index(" ")
      update_board(coor, coor)
    else
      coor = diagonals[1].index(" ")
      if coor == 0
        update_board(2, 0)
      elsif coor == 1
        update_board(1, 1)
      else
        update_board(0, 2)
      end
    end
  end
end

class Blocker < TTT::Computer::Winner
  def move
    if can_win_horiz?
      horiz_win
    elsif can_win_vert?
      vert_win
    else
      diag_win
    end
  end

  def potential_wins
    [opponent, opponent, ' '].permutation.to_a.uniq
  end

  def can_block?
    can_win?
  end
end
