require_relative 'morpion_classes'

def start_game
  board = Board.new
  puts "Veuillez entrer le prénom du premier joueur"
  print ">"
  player1 = Player.new(gets.chomp, "o")
  puts
  puts "Veuillez entrer le prénom du second joueur"
  print ">"
  player2 = Player.new(gets.chomp, "x")
  puts
  puts "*****La partie est lancée!!!*****"
  puts
  return Game.new(player1, player2, board)
end

def show_board(board)
  cases = board.case_names
  puts 
  puts "  1 2 3"
  puts "A #{board.case_hash[cases[0]].content}|#{board.case_hash[cases[1]].content}|#{board.case_hash[cases[2]].content}"
  puts "  _ _ _"
  puts "B #{board.case_hash[cases[3]].content}|#{board.case_hash[cases[4]].content}|#{board.case_hash[cases[5]].content}"
  puts "  _ _ _"
  puts "C #{board.case_hash[cases[6]].content}|#{board.case_hash[cases[7]].content}|#{board.case_hash[cases[8]].content}"
  puts
end


def play_turn(game)
  puts "C'est au tour de #{game.current_player.first_name} (#{game.current_player.symbol})"
  puts "dans quelle case souhaites-tu jouer?"
  print ">"
  input = gets.chomp
  chosen_case = game.board.case_hash[input.upcase]
  if chosen_case #test pour savoir si cette case existe (n'est pas nil)

    if chosen_case.content == " " #test pour vérifier si la case est déjà occupée ou pas (" " = case libre)
      chosen_case.content = game.current_player.symbol
    else
      puts "!! ERREUR: la case est déjà prise. Veuillez recommencer !!"
      puts
      return nil
    end
  else
    puts "!! ERREUR: cette case n'existe pas. Veuillez recommencer !!"
    puts
    return nil

  end
  return chosen_case
end

def new_turn(game)
  #Nous allons changer le joueur qui doit jouer
  player_index = game.player_array.index(game.current_player)
  game.current_player = game.player_array[(player_index+1)%2]
  game.count_turn += 1
end

def game_end(game)
  if game.status == "draw"
    puts "Match nul! Personne ne gagne"
  else
    puts "C'est #{game.status.first_name} qui a gagné!"
  end
end

def look_for_winning_move(game, last_case_played)
  if(game.count_turn < 5)
    return
  end
  row_name = last_case_played.position[0]
  col_name = last_case_played.position[1]
  row_hash_to_test = game.board.case_hash.select{ |k,v| k[0] == row_name}
  col_hash_to_test = game.board.case_hash.select{ |k,v| k[1] == col_name}

  result_row = ""
  result_col = ""
  row_hash_to_test.each do |pos,board_case|
    result_row += board_case.content
  end
  col_hash_to_test.each do |pos,board_case|
    result_col += board_case.content
  end
  if (result_col == "xxx" || result_col == "ooo" ||result_row == "xxx" ||result_row == "ooo")
    game.status = game.current_player
  end
end


def perform
  game = start_game
  show_board(game.board)
  last_case_played = nil

  while(game.status == "on going")

    while(last_case_played == nil)
      last_case_played = play_turn(game)
    end

    show_board(game.board)

    look_for_winning_move(game, last_case_played)

    new_turn(game)
    if (game.count_turn == 10 && game.status == "on going")
      game.status = "draw"
    end
    last_case_played = nil
  end
  
  game_end(game)
end

perform