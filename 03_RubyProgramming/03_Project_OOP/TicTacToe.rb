
class TicTacToe
	def initialize
		new_board
		@board_poisitons = {1 => [0,0],
						 	2 => [0,1],
							3 => [0,2],
							4 => [1,0],
							5 => [1,1],
							6 => [1,2],
							7 => [2,0],
							8 => [2,1],
							9 => [2,2]}

		@indicies_2_positions = {[0,0] => 1,
						 		 [0,1] => 2,
								 [0,2] => 3,
								 [1,0] => 4,
								 [1,1] => 5,
								 [1,2] => 6,
								 [2,0] => 7,
								 [2,1] => 8,
								 [2,2] => 9}
	end

	def new_board
		@game_board = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]

		

		# @game_board = [[nil, nil, nil], [nil, nil, nil], [nil, nil, nil]]
	end

	def have_winner?
		max_dim = 3

		# check each row for a winner
		max_dim.times do |row_col|
			this_row = get_board_row(row_col)
			return true if this_row.all? { |pos| pos == this_row[0]}
			
			this_col = get_board_col(row_col)
			return true if this_col.all? { |pos| pos == this_col[0]}
		end

		# check diagonals for a winner
		2.times do |diagonal|
			this_diagonal = get_diagonal(diagonal)
			return true if this_diagonal.all? { |pos| pos == this_diagonal[0]}
		end
		false
	end

	def get_board_row(row)
		# Returns all the positions on the board at the specified row in an
		# array.
		@game_board[row]
	end

	def get_board_col(col)
		# Returns all positions on the board at the specified column in an
		# array.
		results = []
		3.times do |row|
			results << @game_board[row][col]
		end
		results
	end

	def get_diagonal(direction)
		# Returns all positions on the board along the diagonal. 

		# direction = 0: values along the top left to bottom right diagonal.
		# direction = 1: values along the top right to bottom left diagonal.

		results = []

		if direction==0
			results << @game_board[0][0]
			results << @game_board[1][1]
			results << @game_board[2][2]
		else
			results << @game_board[2][0]
			results << @game_board[1][1]
			results << @game_board[0][2]
		end
		results
	end

	def mark_board(position, marker)
		board_indicies = @board_poisitons[position]
		row = board_indicies[0]
		col = board_indicies[1]
		result = nil
		# check if board poisiton is already marked at the position. return
		# 'nil' if the postion was already marked.
		if @game_board[row][col].class == Fixnum
			@game_board[row][col] = marker
			result = marker
		end
		result
	end

	def print_board
		# The board is printed line by line.

		# static lines: 0, 2, 3, 5, 6, 8 
		# 
		# These lines are produced by method calls that return static strings.

		# dynamic lines: 1, 4, 7
		# 
		# These lines are the positions of each player and change after each
		# round of play.

		# Columns: 01234567890
		#  line 0:    |   |   
		#  line 1:  O | X | O 
		#  line 2: ___|___|___
		#  line 3:    |   |
		#  line 4:  O | X | O
		#  line 5: ___|___|___
		#  line 6:    |   |
		#  line 7:  O | X | O
		#  line 8:    |   |
 
		edge_spacing = "\t"
		puts edge_spacing + get_vertical_board_graphic
		puts edge_spacing + get_player_positons_board_graphic(@game_board[0])
		puts edge_spacing + get_horizontal_board_graphic
		puts edge_spacing + get_vertical_board_graphic
		puts edge_spacing + get_player_positons_board_graphic(@game_board[1])
		puts edge_spacing + get_horizontal_board_graphic
		puts edge_spacing + get_vertical_board_graphic
		puts edge_spacing + get_player_positons_board_graphic(@game_board[2])
		puts edge_spacing + get_vertical_board_graphic
	end

	def get_vertical_board_graphic
		"   |   |   "
	end

	def get_horizontal_board_graphic
		"___|___|___"
	end

	def get_player_positons_board_graphic(player_positions_array)
		result = ""
		11.times do | col_idx |
			# spaces (" ") are contained in columns: 0, 2, 4, 6, 8, 10
			# vertical bar ("|") is contained in columns: 3, 7
			# player postions are contained in columns: 1, 5, 9
			result << " " if [0,2,4,6,8,10].include?(col_idx)
			result << "|" if [3,7].include?(col_idx)
			result << player_position_marker(player_positions_array, col_idx) if [1, 5, 9].include?(col_idx)
		end
		result
	end

	def player_position_marker(player_positions_array, position)
		# position is a value of either: 1, 5, 9 and corrospond to index 0, 1,
		# 2 in player_positions_array.
		
		# if an index in player_postion_array is nil then a space " " is
		# return. Other wise the character at that index is return.
		array_mapping = {1 => 0, 5 => 1, 9 => 2}
		marker = player_positions_array[array_mapping[position]].to_s
		marker ? marker : " "
	end	

	def get_available_positions
		results = []
		3.times do |row|
			3.times do |col|
				if @game_board[row][col].class == Fixnum
					results << @game_board[row][col]
				end
			end
		end
		results.sort
	end

end



class PlayTicTacToe
	def initialize
		# States of the game

		# :in_play - prompts for player input, updates board, displays board,
		# 			 checks for winnder

		# :begin_game - show player statistics, asks for another game.

		# :end_game - end the game

		# :winner - Announce winner, update winner totals, show game statistics.

		# :play_again = asks the player to play another game or exit.

		# :tie = show it's a tie game and ask to play again.

		@game_state = :begin_game
		@players_turn = :X	
		@playerX_wins = 0
		@playerO_wins = 0

		new_game
	end 

	def new_game
		@game_board = TicTacToe.new

		# @game_board.mark_board(1, 'O')
		# @game_board.mark_board(2, 'X')
		# @game_board.mark_board(3, 'O')

		# @game_board.mark_board(4, 'X')
		# @game_board.mark_board(5, 'X')
		# @game_board.mark_board(6, 'O')

		# @game_board.mark_board(7, '0')
		# @game_board.mark_board(8, '0')
		

	end

	def play_game
		@play_game = true
		while @play_game
			case @game_state
			when :begin_game
				begin_game
			when :in_play
				get_player_input
			when :end_game
				@play_game = false
			when :winner
				display_winner
			when :play_again
				display_play_again
			when :tie
				display_tie_game
			end	
		end
	end

	def display_play_again
		user_prompt = "(P)lay another game of Tic Tac Toe?\n"
		user_prompt += get_end_game_message
		user_prompt += "\n"
		
		prompt_for_play(user_prompt)

		if @game_state == :in_play
			@game_board = TicTacToe.new
			# The first player for the next game is whoever lost
			switch_players
		end
	end

	def display_winner
		if @players_turn == :X
			@playerX_wins += 1
		else
			@playerO_wins += 1
		end

		message = "Player #{@players_turn} WINS!!!\n\n"
		message += "Final board:\n\n"
		puts message
		@game_board.print_board

		message = "\n"
		message += get_player_stats
		message += "\n"
		puts message
		@game_state = :play_again
	end

	def get_player_input
		message = "It's player "
		message += @players_turn==:X ? "X" : "O"
		message += "'s turn.\n"
		message += "Player #{@players_turn} please select your next position.\n"
		valid_positions = @game_board.get_available_positions
		if valid_positions.length == 0 
			@game_state = :tie
			return
		end

		message +=  "Please enter one of the following positions: #{valid_positions}"
		
		@game_board.print_board
		
		response = get_user_input(message).to_i
		if valid_positions.include?(response)
			@game_board.mark_board(response, @players_turn.to_s)
			# check for winner
			if @game_board.have_winner?
				@game_state = :winner
			else
				switch_players
			end
		else
			puts "#{response} is an invalid position. Try again."
			get_player_input
		end
	end

	def switch_players
		@players_turn = @players_turn == :X ? :O : :X
	end

	def display_tie_game
		message = "CAT!!!\n"
		message += "Neither player wins.\n"
		message += get_player_stats
		message += "\n"
		puts message
		@game_state = :play_again
	end

	def begin_game
		# user_prompt = get_player_stats
		# user_prompt += "\n"
		user_prompt = "(P)lay a game of Tic Tac Toe?\n"
		user_prompt += get_end_game_message
		user_prompt += "\n"
		
		prompt_for_play(user_prompt)
		# response = get_user_input(user_prompt)
		# response.upcase!
		# if response == 'P'
		# 	@game_state = :in_play
		# elsif response == 'E'
		# 	@game_state = :end_game
		# else
		# 	puts "I did not understand your response, Try again."
		# 	puts 
		# 	begin_game
		# end
	end

	def prompt_for_play(message)
		response = get_user_input(message)
		response.upcase!
		if response == 'P'
			@game_state = :in_play
		elsif response == 'E'
			@game_state = :end_game
		else
			puts "I did not understand your response, Try again."
			puts 
			begin_game
		end
	end


	def get_end_game_message
		"(E)xit the game?\n"
	end

	def get_player_stats
		stats = "Player X wins: #{@playerX_wins}\n"
		stats += "Player O wins: #{@playerO_wins}\n"
	end

	def get_user_input(message)
		puts message
		gets.chomp
	end
end

myPlayTicTacToe = PlayTicTacToe.new
myPlayTicTacToe.play_game


# puts myPlayTicTacToe.get_user_input("Press A")

# myTicTacToe = TicTacToe.new
# myTicTacToe.mark_board(1, 'X')
# myTicTacToe.mark_board(2, 'X')
# myTicTacToe.mark_board(3, 'X')
# myTicTacToe.mark_board(3, '0')

# myTicTacToe.print_board

# print myTicTacToe.get_available_positions
# puts

# puts myTicTacToe.have_winner?

# myTicTacToe = TicTacToe.new
# myTicTacToe.mark_board(4, 'O')
# myTicTacToe.mark_board(5, 'O')
# myTicTacToe.mark_board(6, 'X')

# myTicTacToe.print_board

# puts myTicTacToe.have_winner?

# myTicTacToe = TicTacToe.new
# myTicTacToe.mark_board(1, 'X')
# myTicTacToe.mark_board(4, 'X')
# myTicTacToe.mark_board(7, 'X')

# myTicTacToe.print_board

# puts myTicTacToe.have_winner?

# myTicTacToe.mark_board(3, '0')

# myTicTacToe = TicTacToe.new
# myTicTacToe.mark_board(2, 'O')
# myTicTacToe.mark_board(5, 'O')
# myTicTacToe.mark_board(8, 'O')

# myTicTacToe.print_board

# puts myTicTacToe.have_winner?

# myTicTacToe = TicTacToe.new
# myTicTacToe.mark_board(3, 'X')
# myTicTacToe.mark_board(6, 'X')
# myTicTacToe.mark_board(9, 'X')

# myTicTacToe.print_board

# puts myTicTacToe.have_winner?

# myTicTacToe = TicTacToe.new
# myTicTacToe.mark_board(1, 'O')
# myTicTacToe.mark_board(5, 'O')
# myTicTacToe.mark_board(9, 'O')

# myTicTacToe.print_board

# puts myTicTacToe.have_winner?

# myTicTacToe = TicTacToe.new
# myTicTacToe.mark_board(3, 'X')
# myTicTacToe.mark_board(5, 'X')
# myTicTacToe.mark_board(7, 'X')

# myTicTacToe.print_board

# puts myTicTacToe.have_winner?

# print myTicTacToe.get_available_positions
# puts 

# myTicTacToe = TicTacToe.new
# myTicTacToe.print_board
# puts myTicTacToe.have_winner?


# print myTicTacToe.get_board_row(0)
# puts
# print myTicTacToe.get_board_row(1)
# puts
# print myTicTacToe.get_board_row(2)
# puts

# print myTicTacToe.get_board_col(0)
# puts
# print myTicTacToe.get_board_col(1)
# puts
# print myTicTacToe.get_board_col(2)
# puts
# puts
# print myTicTacToe.get_diagonal(0)
# puts
# print myTicTacToe.get_diagonal(1)
# puts
# myTicTacToe.get_player_positons_board_graphic(['X', nil, 'O'])
# puts myTicTacToe.player_position_marker(['X', nil, 'O'], 1)
# puts myTicTacToe.player_position_marker(['X', nil, 'O'], 5)
# puts myTicTacToe.player_position_marker(['X', nil, 'O'], 9)







