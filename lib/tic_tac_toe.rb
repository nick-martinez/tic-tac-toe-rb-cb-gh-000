# WIN_COMBINATIONS = [[0,1,2], [3,4,5], [6,7,8], # ROW WINS
#                     [0,3,6], [1,4,7], [2,5,8], # COLUMN WINS
#                     [0,4,8], [2,4,6]] # DIAGONAL WINS
#
#
# def display_board(board)
#   puts " #{board[0]} | #{board[1]} | #{board[2]} "
#   puts "-----------"
#   puts " #{board[3]} | #{board[4]} | #{board[5]} "
#   puts "-----------"
#   puts " #{board[6]} | #{board[7]} | #{board[8]} "
# end # end display_board
#
#
# def input_to_index(input)
#   index = input.to_i
#   index -= 1
#   return index
# end # end input_to_index
#
#
# def move(board, index, character)
#   board[index] = character
# end # end move
#
#
# def position_taken?(array, ind)
#   if (array[ind] == " " || array[ind] == "" || array[ind] == nil)
#     return false
#   else
#     return true
#   end
# end # end position_taken?
#
#
# def on_board?(ind)
#   if (ind.between?(0,8) == true)
#     return true
#   else
#     return false
#   end
# end # end on_board?
#
#
# def valid_move?(board, index)
#   if (position_taken?(board, index)) == false && (on_board?(index) == true)
#     return true
#   else
#     return false
#   end
# end # end valid_move
#
#
# def turn(board)
#   puts "Please enter 1-9:"
#   input = gets.strip
#   index = input_to_index(input)
#   if valid_move?(board, index) == true
#     move(board, index)
#     display_board(board)
#   else
#     turn(board)
#   end
# end # end turn
#
#
# def turn_count(board)
#   counter = 0
#   square = 0
#
#   while (square < board.size)
#     if (board[square] != " " && board[square] != "" && board[square] != nil)
#       counter += 1
#     end
#     square += 1
#   end
#
#   return counter
# end # End turn_count
#
#
# def current_player(board)
#   if (turn_count(board) % 2 == 0)
#     return "X"
#   else
#     return "O"
#   end
# end # End current_player
#
#
# def won?(board)
#   WIN_COMBINATIONS.each do |ttt_win|
#
#     win_index_1 = ttt_win[0]
#     win_index_2 = ttt_win[1]
#     win_index_3 = ttt_win[2]
#
#     position_1 = board[win_index_1]
#     position_2 = board[win_index_2]
#     position_3 = board[win_index_3]
#
#     if (position_1 == "X" && position_2 == "X" && position_3 == "X")
#       return ttt_win
#     elsif (position_1 == "O" && position_2 == "O" && position_3 == "O")
#       return ttt_win
#     end
#   end
#   #else
#   return false
# end # End won(board)
#
#
# def full?(board)
#   board.all? {|square| square == "X" || square == "O"}
# end # End full?(board)
#
#
# def draw?(board)
#   if (full?(board) == true && won?(board) == false)
#     return true
#   else
#     return false
#   end
# end # End draw?(board)
#
#
# def over?(board)
#   if (won?(board) || draw?(board))
#     return true
#   else
#     return false
#   end
# end # End over?(board)
#
#
# def winner(board)
#   index = []
#   index = won?(board)
#
#   if (index == false)
#     return nil
#   else
#     if (board[index[0]] == "X")
#       return "X"
#     else
#       return "O"
#     end
#   end
# end # End winner(board)
#
#
# def play(board)
#   while (over?(board) != true)
#     turn(board)
#   end
#
#   if (won?(board))
#     puts "Congratulations #{winner(board)}!"
#   elsif (draw?(board))
#     puts "Cat's Game!"
#   end
# end  # End play


WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [6, 4, 2]
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, index)
  !(board[index].nil? || board[index] == " ")
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn_count(board)
  turn = 0
  board.each do |index|
    if index == "X" || index == "O"
      turn += 1
    end
  end
  return turn
end

def current_player(board)
  #if the turn count is an even number, that means O just went, so the next/current player is X
  num_turns = turn_count(board)
  if num_turns % 2 == 0
    player = "X"
  else
    player = "O"
  end
  return player
end

def turn(board)
  puts "Please choose a number 1-9:"
  user_input = gets.chomp
  index = input_to_index(user_input)
  if valid_move?(board, index)
    player_token = current_player(board)
    move(board, index, player_token)
    display_board(board)
  else
    turn(board)
  end
end

def won?(board)
  WIN_COMBINATIONS.each {|win_combo|
    index_0 = win_combo[0]
    index_1 = win_combo[1]
    index_2 = win_combo[2]

    position_1 = board[index_0]
    position_2 = board[index_1]
    position_3 = board[index_2]

    if position_1 == "X" && position_2 == "X" && position_3 == "X"
      return win_combo
    elsif position_1 == "O" && position_2 == "O" && position_3 == "O"
      return win_combo
    end
  }
  return false
end

def full?(board)
  board.all? {|index| index == "X" || index == "O"}
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  else
    return false
  end
end

def over?(board)
  if won?(board) || draw?(board)
    return true
  else
    return false
  end
end

def winner (board)
  index = []
  index = won?(board)
  if index == false
    return nil
  else
    if board[index[0]] == "X"
      return "X"
    else
      return "O"
    end
  end
end

def play(board)
  until over?(board) == true
    turn(board)
  end

  if won?(board)
    puts "Congratulations #{winner(board)}!"
  elsif draw?(board)
    puts "Cats Game!"
  end
end
