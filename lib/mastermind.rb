# TODO:

# dynamic ANSI colored pegs for when the user inputs
# CLI green load with an animation and a music file and VFX

#########################################

# Sprint 1 from Pivotal Tracker

# The game board is rendered between turns

# The player only gets 12 turns to crack the code

# The player wins if the code is correctly guessed by the last turn

# The rendered board displays the number and position of "close" pegs
# (correct color, wrong position)

# The rendered board displays the position of "exact" pegs, e.g. those
# which exactly match the color and position of the computer's code

# The player loses after the 12th turn if the code hasn't been broken

# When losing, the code is displayed to the player

# V 1.0 Gameplay:

# Game initializes with a code and a code_breaker
# Computer generates code
# Computer prompts code_breaker for a guess
# The guess is tested against the code
# win is checked
#   win is all colors and positions match
# the response is rendered
# repeat until games > 12 or win

# Pseudo Code
# Set up the game [Mastermind]
# 	create a @board [Board]
# 	create a @code [CodeMaker]
# 	create a @code_breaker [CodeBreaker]
# Start the game loop [Mastermind]
# 	render the board [Board]
# 	Ask for player to guess and validate guess
# 	If game ends [Mastermind]
# 		render the victory/ lose message
# 		stop loop
# 	else
# 		Keep looping [Mastermind]
# NOTE: the RESULT holds the guesses and checks them against the code
# then returns the result array. The render function renders this result.
# Should the board render in full with all results each round?


require 'pry'

# this module is for all of the CLI formatting and coloring mixins
module Formats

	# create array of possible colors from which to choose
	POSSIBLE_COLORS = %w(R G B Y C P)


	def colorize(peg)
		text = peg
		color_code = case peg
			when "R"
				color_code = 31
			when "B"
				color_code = 34
			when "G"
				color_code = 32
			when "Y"
				color_code = 33
			when "C"
				color_code = 36
			when "P"
				color_code = 35
			else
				"X"
		end
		print "\e[#{color_code}m#{text}\e[0m"
	end


end

# controls gameplay
class Mastermind

	include Formats

	attr_reader :board, :code_maker, :code_breaker, :turns

	def initialize

		# set up the board
		@board = Board.new

		# create the secret code
		@code_maker = CodeMaker.new

		# set up the code_breaker
		@code_breaker = CodeBreaker.new

		# create the turns counter
		@turns = 12

	end

	def play

		welcome_player
		explain_rules

		loop do # refactor to a while that automatically ends in loss?
			puts "Starting game loop"
			# render the board
			board.render
			# check the guess against the code
			board.generate_result(@code_breaker.guess, @code_maker.code) # write this in class Board
			# break the loop if the game ends
			check_game_end
			# remove one from the turns counter
			@turns -= 1
		end
	end

	def welcome_player
		# render the initial message
		return "Welcome to Mastermind!"
	end

	def explain_rules
		puts "Try to beat the computer by guessing the secret code!"
		# display the message prompting first guess
		puts "You can choose a combination of four from:\n[\e[31mR:RED\e[0m][\e[32mG:GREEN\e[0m][\e[33mY:YELLOW\e[0m][\e[34mB:BLUE\e[0m][\e[36mC:CYAN\e[0m][\e[35mP:PURPLE\e[0m]"
		puts "in the form of #{colorize('R')}#{colorize('G')}#{colorize('Y')}#{colorize('R')}"
		puts "What is your guess?"
	end

	def check_game_end
		check_loss || check_victory
	end

	def check_victory
		# if board says victory is acheived
		# render win scenario
		return "Oh. You won... Congrats, I guess" if board.win?

	end

	def check_loss
		# if run out of turns
		# render lose scenario
		return "You have lost the game" if (turns <= 0)
	end

end

# the game state
class Board

	include Formats

	attr_reader :result

	def initialize
		# create an empty array to hold the result of each checked guess
		@board = Array.new(12){Array.new(4)}
	end

	def render
		# loop through the board array and display the result using colorize
			unless (@board[0].include?(nil))
				puts "Board rendered"
				@board.each do |result|
					result.each { |peg| puts "|#{colorize(peg)}|" }
				end
			end
	end


	# this should definitely be broken into more methods
	def generate_result(guess, code)
		@result = Array.new(4)
		# for each peg in guess
		guess.each_with_index do |guess_peg, guess_index|
			# compare against secret code
			code.each_with_index do |code_peg, code_index|
				# if both color(peg) and position(index) match
				if ((guess_peg == code_peg) && (guess_index == code_index))
					# save WHITE(W) peg in that position
					@result[code_index] = "W"
				# if only color matches any other position
				elsif ((guess_peg == code_peg) && (guess_index != code_index))
					# save a BLACK(M) peg in that postion
					@result[guess_index] = "M"
				else
					# put an X in that position
					@result[guess_index] = "X"
				end
			end
		end
		@board.unshift(@result)
	end

	def win?
		# does result have all_white_pegs?
		@result.all? do |peg|
			peg == "W"
		end
	end

end

# the human player
class CodeBreaker

	include Formats

	attr_accessor :guess

	def initialize
	end

	def guess
		"guess"
		loop do
			"loop started"
			# this is terrible naming - I am is confused
			guess = ask_for_guess

			if (validate_guess_format(guess))
				return guess.split(//).each(&:upcase)
			else
				puts "You need to format as four sequential colors"
			end

		end
	end

	def ask_for_guess
		# get the guess
		guess = gets.strip
		return guess
	end

	def validate_guess_format(guess)
		# unless guess is proper format
		(guess.size == 4) && (check_colors_format(guess, POSSIBLE_COLORS))
	end

	def check_colors_format(guess, colors)
		guess.split(//).all? do |peg|
			colors.include?(peg)
		end
	end

end

# the computer that creates the code
class CodeMaker

	include Formats

	attr_reader :code

	def initialize

		@code = create_secret_code(POSSIBLE_COLORS)

	end

	def create_secret_code(possible_colors)
		# set code to a random set of four pegs
		random_code = []
		4.times do
			random_code << possible_colors.sample(1)
		end
		return random_code
	end
end

# run the game from the file
m = Mastermind.new
m.play