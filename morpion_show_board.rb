def show_board(game)
  cases = game.board.case_names
  puts 
  puts "#"*60
  puts "#"*60
  
  print "#"*20
  print "-"*20
  puts "#"*20
  
  print "#"*20
  print "|      SCORES      |"
  puts "#"*20

  print "#"*20
  print "| Player 1     #{game.win_count[game.player_array[0]]}   |"
  puts "#"*20  

  print "#"*20
  print "| Player 2     #{game.win_count[game.player_array[1]]}   |"
  puts "#"*20  

  print "#"*20
  print "| Draws        #{game.win_count['draw']}   |"
  puts "#"*20  

  print "#"*20
  print "-"*20
  puts "#"*20
  puts "#"*60
  puts "#"*60

  print "#"*20
  print " "*20
  puts "#"*20

  print "#"*20
  print " "*6
  print "  1 2 3 "
  print " "*6
  puts "#"*20

  print "#"*20
  print " "*6
  print "A #{game.board.case_hash[cases[0]].content}|#{game.board.case_hash[cases[1]].content}|#{game.board.case_hash[cases[2]].content} "
  print " "*6
  puts "#"*20

  print "#"*20
  print " "*6
  print "  ----- "
  print " "*6
  puts  "#"*20

  print "#"*20
  print " "*6
  print "B #{game.board.case_hash[cases[3]].content}|#{game.board.case_hash[cases[4]].content}|#{game.board.case_hash[cases[5]].content} "
  print " "*6
  puts "#"*20

  print "#"*20
  print " "*6
  print "  ----- "
  print " "*6
  puts "#"*20

  print "#"*20
  print " "*6
  print "C #{game.board.case_hash[cases[6]].content}|#{game.board.case_hash[cases[7]].content}|#{game.board.case_hash[cases[8]].content} "
  print " "*6
  puts "#"*20

  print "#"*20
  print " "*20
  puts "#"*20

  puts "#"*60
  puts "#"*60


  puts
end