class Board
  attr_accessor :count_turn
  attr_reader :case_hash
  @@case_names = ["A1","A2","A3","B1","B2","B3","C1","C2","C3"]

  def initialize
    @case_hash = Hash.new
    @@case_names.each do |case_str|
      @case_hash[case_str] = BoardCase.new(case_str)
    end
    @count_turn = 1

  end

  def case_names
    return @@case_names
  end

end

class BoardCase
  attr_accessor :content
  attr_reader :position

  def initialize(position)
    @position = position
    @content = " "
  end

end

class Player
  attr_reader :first_name, :symbol

  def initialize(first_name, symbol)
    @first_name = first_name
    @symbol = symbol
  end


end

class Game
  attr_accessor :current_player, :status, :win_count, :board
  attr_reader :player_array

  def initialize(player1, player2, board)
    @player_array = [player1, player2]
    @board = board
    @status = "on going"
    @current_player = player1
    @win_count = Hash.new
    @win_count['draw'] = 0
    @win_count[player1] = 0
    @win_count[player2] = 0
  end


end
