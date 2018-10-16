class Board #classe définissant le plateau de jeu

  attr_accessor :count_turn #compteur de tour au sein d'un round (pour identifier les matchs nuls)
  attr_reader :case_hash #hash contenant les 9 cases
  
  @@case_names = ["A1","A2","A3","B1","B2","B3","C1","C2","C3"] #variable de classe pour identifier les 9 cases

  def initialize
    @case_hash = Hash.new

    #initialisation de l'ensemble des cases du board
    @@case_names.each do |case_str|
      @case_hash[case_str] = BoardCase.new(case_str)
    end

    #
    @count_turn = 1

  end

  def case_names #permet de lire la variable de classe @@case_names
    return @@case_names
  end

end

class BoardCase #classe définissant 1 case
  attr_accessor :content #contenu de la case (" " ou "o" ou "x")
  attr_reader :position #position de la case ("A1", "B2", etc.)

  def initialize(position)
    @position = position
    @content = "  "
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
