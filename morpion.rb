require_relative 'morpion_classes'
require_relative 'morpion_show_board'

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

def new_round(game)
  game.board = Board.new
  game.status = "on going"
  num_rounds = game.win_count['draw']+ game.win_count[game.player_array[0]]+game.win_count[game.player_array[1]]
  if num_rounds%2 == 0
    game.current_player = game.player_array[0]
  else
    game.current_player = game.player_array[1]
  end
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
  game.board.count_turn += 1
end

def game_end(game)
  if game.status == "draw"
    game.win_count['draw'] += 1
    puts "Match nul! Personne ne gagne"
  else
    game.win_count[game.status] += 1
    puts "C'est #{game.status.first_name} qui a gagné!"
  end
end

def look_for_winning_move(game, last_case_played)
  if(game.board.count_turn < 5)
    return
  end

  #Vérification sur la ligne et la colonne autour de la last_case_played
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

  #Vérification sur les 2 diagonales du board
  diag1_hash_to_test = game.board.case_hash.select{ |k,v| k == "A1" || k == "B2" || k == "C3"}
  diag2_hash_to_test = game.board.case_hash.select{ |k,v| k == "A3" || k == "B2" || k == "C1"}
  result_diag1 = ""
  result_diag2 = ""
  diag1_hash_to_test.each do |pos,board_case|
    result_diag1 += board_case.content
  end
  diag2_hash_to_test.each do |pos,board_case|
    result_diag2 += board_case.content
  end
  result_array = [result_col, result_row, result_diag1, result_diag2]
  if result_array.include?("xxx") || result_array.include?("ooo")
    game.status = game.current_player
  end
end


def perform
  game = start_game

  keep_playing = true
  while(keep_playing)
    show_board(game)
    last_case_played = nil

    while(game.status == "on going")

      while(last_case_played == nil)
        last_case_played = play_turn(game)
      end

      show_board(game)

      look_for_winning_move(game, last_case_played)

      new_turn(game)
      if (game.board.count_turn == 10 && game.status == "on going")
        game.status = "draw"
      end
      last_case_played = nil
    end
    game_end(game)
    puts
    puts" Voulez-vous rejouer une partie?"
    print "(Y/N) >"
    input = gets.chomp
    if input.downcase == "y"
      new_round(game)
    else
      keep_playing = false
    end
  end

end

perform