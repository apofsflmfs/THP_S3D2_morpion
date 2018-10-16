require 'colorize'

String.colors

def show_board(game)
  cases = game.board.case_names
  global_background = :light_white
  score_background = :black
  board_background = :black
  player1_color = :red
  player2_color = :green
  puts 
  puts (" "*60).colorize(:background => global_background)
  puts (" "*60).colorize(:background => global_background)
  
  print (" "*20).colorize(:background => global_background)
  print ("-"*20).colorize(:background => score_background)
  puts (" "*20).colorize(:background => global_background)
  
  print (" "*20).colorize(:background => global_background)
  print ("|      SCORES      |").colorize(:background => score_background)
  puts (" "*20).colorize(:background => global_background)

  print (" "*20).colorize(:background => global_background)
  print ("|").colorize(:background => score_background)
  print (" Player 🔥    #{game.win_count[game.player_array[0]]}   ").colorize(:color => player1_color, :background => score_background)
  print ("|").colorize(:background => score_background)
  puts (" "*20).colorize(:background => global_background)

  print (" "*20).colorize(:background => global_background)
  print ("|                  |").colorize(:background => score_background)
  puts (" "*20).colorize(:background => global_background)

  print (" "*20).colorize(:background => global_background)
  print ("|").colorize(:background => score_background)
  print (" Player 🌊    #{game.win_count[game.player_array[1]]}   ").colorize(:color => player2_color, :background => score_background)
  print ("|").colorize(:background => score_background)
  puts (" "*20).colorize(:background => global_background)

  print (" "*20).colorize(:background => global_background)
  print ("|                  |").colorize(:background => score_background)
  puts (" "*20).colorize(:background => global_background)

  print (" "*20).colorize(:background => global_background)
  print ("| Draws        #{game.win_count['draw']}   |").colorize(:background => score_background)
  puts (" "*20).colorize(:background => global_background)

  print (" "*20).colorize(:background => global_background)
  print ("-"*20).colorize(:background => score_background)
  puts (" "*20).colorize(:background => global_background)
  puts (" "*60).colorize(:background => global_background)
  puts (" "*60).colorize(:background => global_background)

  print (" "*20).colorize(:background => global_background)
  print (" "*20).colorize(:background => board_background)
  puts (" "*20).colorize(:background => global_background)

  print (" "*20).colorize(:background => global_background)
  print (" "*4).colorize(:background => board_background)
  print ("  1  2  3 ").colorize(:background => board_background)
  print (" "*6).colorize(:background => board_background)
  puts (" "*20).colorize(:background => global_background)

  print (" "*20).colorize(:background => global_background)
  print (" "*4).colorize(:background => board_background)
  print ("A ").colorize(:background => board_background)
  print ("#{game.board.case_hash[cases[0]].content}").colorize(:color => game.board,:background => board_background)
  print ("|").colorize(:background => board_background)
  print ("#{game.board.case_hash[cases[1]].content}").colorize(:background => board_background)
  print ("|").colorize(:background => board_background)
  print ("#{game.board.case_hash[cases[2]].content} ").colorize(:background => board_background)
  print (" "*5).colorize(:background => board_background)
  puts (" "*20).colorize(:background => global_background)

  print (" "*20).colorize(:background => global_background)
  print (" "*4).colorize(:background => board_background)
  print ("  --------- ").colorize(:background => board_background)
  print (" "*4).colorize(:background => board_background)
  puts (" "*20).colorize(:background => global_background)

  print (" "*20).colorize(:background => global_background)
  print (" "*4).colorize(:background => board_background)
  print ("B ").colorize(:background => board_background)
  print ("#{game.board.case_hash[cases[3]].content}").colorize(:background => board_background)
  print ("|").colorize(:background => board_background)
  print ("#{game.board.case_hash[cases[4]].content}").colorize(:background => board_background)
  print ("|").colorize(:background => board_background)
  print ("#{game.board.case_hash[cases[5]].content} ").colorize(:background => board_background)
  print (" "*5).colorize(:background => board_background)
  puts (" "*20).colorize(:background => global_background)

  print (" "*20).colorize(:background => global_background)
  print (" "*4).colorize(:background => board_background)
  print ("  --------- ").colorize(:background => board_background)
  print (" "*4).colorize(:background => board_background)
  puts (" "*20).colorize(:background => global_background)

  print (" "*20).colorize(:background => global_background)
  print (" "*4).colorize(:background => board_background)
  print ("C ").colorize(:background => board_background)
  print ("#{game.board.case_hash[cases[6]].content}").colorize(:background => board_background)
  print ("|").colorize(:background => board_background)
  print ("#{game.board.case_hash[cases[7]].content}").colorize(:background => board_background)
  print ("|").colorize(:background => board_background)
  print ("#{game.board.case_hash[cases[8]].content} ").colorize(:background => board_background)
  print (" "*5).colorize(:background => board_background)
  puts (" "*20).colorize(:background => global_background)

  print (" "*20).colorize(:background => global_background)
  print (" "*20).colorize(:background => board_background)
  puts (" "*20).colorize(:background => global_background)

  puts (" "*60).colorize(:background => global_background)
  puts (" "*60).colorize(:background => global_background)


  puts
end