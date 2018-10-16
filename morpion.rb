require_relative 'morpion_classes'
require_relative 'morpion_show_board'

def start_game #initialise le jeu
  board = Board.new #création d'un board vierge (9 cases vides)

  puts "Veuillez entrer le prénom du premier joueur"
  print ">"
  player1 = Player.new(gets.chomp, "🔥") #création du premier joueur
  puts

  puts "Veuillez entrer le prénom du second joueur"
  print ">"
  player2 = Player.new(gets.chomp, "🌊") #création du second joeur
  puts

  puts "*****La partie est lancée!!!*****"
  puts

  return Game.new(player1, player2, board) #retour un objet "game" contenant les 2 joeurs et le board vierge
end

def play_turn(game) #permet de faire un tour de jeu
  puts "C'est au tour de #{game.current_player.first_name} (#{game.current_player.symbol})" #on identifie le joueur dont c'est le tour
  puts "dans quelle case souhaites-tu jouer?"
  print ">"
  input = gets.chomp 
  chosen_case = game.board.case_hash[input.upcase] #case choisie par le joueur dont c'est le tour

  if chosen_case #test pour savoir si cette case existe (n'est pas nil)

    if chosen_case.content == "  " #test pour vérifier si la case est déjà occupée ou pas ("  " = case libre)
      chosen_case.content = game.current_player.symbol #si vide, on la remplie avec le symbole du joueur qui joue
    else

      puts "!! ERREUR: la case est déjà prise. Veuillez recommencer !!"
      puts
      return nil #indique que le tour a échoué et doit être rejoué
    end

  else #cas où la case choisie n'existe pas
    puts "!! ERREUR: cette case n'existe pas. Veuillez recommencer !!"
    puts
    return nil #indique que le tour a échoué et doit être rejoué

  end
  return chosen_case #indique que le tour a fonctionné. Permet de garder en mémoire quelle case vient d'être jouée.
end

def new_round(game) #permet de relancer une partie (nouveau board mais mêmes joueurs)

  #réinitialise le board et le game.status
  game.board = Board.new
  game.status = "on going"

  #on calcule combien de parties ont été faites
  num_rounds = game.win_count['draw']+ game.win_count[game.player_array[0]]+game.win_count[game.player_array[1]]

  #si le nombre de partie est pair, c'est au player1 de commencer la prochaine. Sinon player2
  if num_rounds%2 == 0
    game.current_player = game.player_array[0]
  else
    game.current_player = game.player_array[1]
  end
end

def new_turn(game) #prépare le jeu à un nouveau tour (le dernier coup n'a pas été gagnant)

  #Nous allons changer le joueur qui doit jouer
  player_index = game.player_array.index(game.current_player)
  game.current_player = game.player_array[(player_index+1)%2]

  game.board.count_turn += 1 #incrémente le compteur de tours
end

def game_end(game) #Permet l'affichage de fin de partie
  if game.status == "draw"
    game.win_count['draw'] += 1
    puts "Match nul! Personne ne gagne"
  else
    game.win_count[game.status] += 1
    puts "C'est #{game.status.first_name} qui a gagné!"
  end
end

def look_for_winning_move(game, last_case_played) #permet de chercher si le dernier coup a été gagnant

  if(game.board.count_turn < 5) #inutile de chercher pour les 4 premiers coups (impossible qu'ils le soient)
    return
  end

  #Vérification sur la ligne de la last_case_played
  row_name = last_case_played.position[0] #on identifie la lettre de la case
  row_hash_to_test = game.board.case_hash.select{ |k,v| k[0] == row_name} #on isole les cases à tester
  result_row = "" #ce sera notre indicateur de coup gagnant
  row_hash_to_test.each do |pos,board_case|
    result_row += board_case.content
  end #on concatène le contenu (string) des 3 cases dans l'indicateur resul_row

  #idem que pour row mais avec la colonne
  col_name = last_case_played.position[1]
  col_hash_to_test = game.board.case_hash.select{ |k,v| k[1] == col_name}
  result_col = ""
  col_hash_to_test.each do |pos,board_case|
    result_col += board_case.content
  end

  #Vérification sur la 1ère diagonale du board
  diag1_hash_to_test = game.board.case_hash.select{ |k,v| k == "A1" || k == "B2" || k == "C3"} #on isole les 3 cases de la diagonale. le reste est comme pour row
  result_diag1 = ""
  diag1_hash_to_test.each do |pos,board_case|
    result_diag1 += board_case.content
  end

  #Vérification sur la 2ème diagonale du board. Idem que l'autre
  diag2_hash_to_test = game.board.case_hash.select{ |k,v| k == "A3" || k == "B2" || k == "C1"}
  result_diag2 = ""
  diag2_hash_to_test.each do |pos,board_case|
    result_diag2 += board_case.content
  end

  result_array = [result_col, result_row, result_diag1, result_diag2] #on met tous nos resultats dans un tableau

  #on teste sur le tableau contient un alignement. Si oui, le game.status est changé.
  if result_array.include?("🌊🌊🌊") || result_array.include?("🔥🔥🔥")
    game.status = game.current_player
  end
end


def perform #orchestrateur du jeu
  game = start_game #on initialise le jeu en réant un objet "game"

  keep_playing = true #permet de faire autant de parties que l'on veut avec les 2 mêmes joueurs
  while(keep_playing)

    show_board(game) #affiche le plateau de jeu en début de partie
    last_case_played = nil

    while(game.status == "on going") #permet d'indiquer que la partie en cours n'est pas terminée

      while(last_case_played == nil) #permet de détecter si une case vient d'être jouée ou si le joueur s'est trompé dans sa saisie
        last_case_played = play_turn(game)#si play_turn fonctionne bien, elle retourne un objet "BoardCase" sinon nil.
      end

      show_board(game) #affiche le plateau de jeu après le choix de jeu

      look_for_winning_move(game, last_case_played) #tester si le coup précédent était gagnant ou pas

      #on teste si on est arrivé au 9ème coup sans vainqueur: si oui, match nul
      if (game.board.count_turn == 9 && game.status == "on going")
        game.status = "draw"
      end

      new_turn(game) #on repart sur un tour (changement de joueur courant et incrémentation du compteur)
      last_case_played = nil #on réinitialise cette variable pour que le while ci-dessus marche à nouveau
    end

    game_end(game) #si on sort de la boucle while d'avant, c'est que la partie est finie. On lance cet affichage.

    #on propose une nouvelle partie
    puts
    puts" Voulez-vous rejouer une partie avec les mêmes joueurs?"
    print "(Y/N) >"
    input = gets.chomp
    if input.downcase == "y"
      new_round(game) #permet de relancer une partie (nouveau board mais mêmes joueurs)
    else
      keep_playing = false #permet de sortie du while et donc du programme
    end
  end
end

perform