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
# NOTE: the board holds the guesses and checks them against the code
# then returns the result array.

require 'pry'

# this module is for all of the CLI formatting and coloring mixins
module Formats

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
		return "\e[#{color_code}m#{text}\e[0m"
	end


end

# controls gameplay
class Mastermind

	include Formats

	def initialize
		# create array of possible colors from which to choose
		@possible_colors = %w(R G B Y C P)
		# set up the board
		@board = Board.new
		# set up the code
		@code_maker = CodeMaker.new
		@code_maker.code(@possible_colors)

		# set up the code_breaker
		@code_breaker = CodeBreaker.new

		# create the turns variable
		@turns = 12
	end

	def play
		# render the initial message
		puts "\nWelcome to Mastermind!"
		loop do
			puts "\nstarting game loop"
			# render the board
			@board.render
			# ask for a guess
			@code_breaker.get_guess
			# break the loop if the game ends
			check_game_end
			# remove one from the turns counter
			@turns -= 1
		end
	end

	def check_game_end
		check_loss || check_victory
	end

	def check_victory
		# if board says guess matches code
		if (@board.check_guess)
			# render win scenario
			puts "You have won!"
		end
	end

	def check_loss
		# if run out of turns
		if (@turns <= 0)
			# render lose scenario
			puts "You have lost the game"
		end
	end

end

# the game state
class Board
	include Formats
	attr_accessor :board

	def initialize
		# create an empty array to hold the result of the checked guess
		@board = Array.new(4)

	end

	def render
		puts "Board rendered"
		# loop through the board array
		@board.each do |peg|
			# display the result using colorize
			"|#{colorize(peg)}|"
		end
	end


	def check_guess
		# for each peg in guess against code
			# if both both color and position match
				# save WHITE peg in that position
			# if only color matches any other position
				# save a BLACK peg in that postion
			# else
				# save an X in that position
	end
	# check_win
		# does result have all_white_pegs?

	# all_white_pegs?
		# check if each element in result is white


end

# the human player
class CodeBreaker
	include Formats
	attr_accessor :guess

	def initialize
	end

	def get_guess
		loop do
			ask_for_guess
			if (validate_guess_format(@guess))
				@guess = @guess.split(//) # careful there bessy
				if @board.check_guess(@guess) # write this in class Board
					break
				end
			end
		end
	end

	def ask_for_guess
		# display the message prompting guess
		puts "What is your guess?\nYou can choose a combination of four from:\n[\e[31mR:RED\e[0m][\e[32mG:GREEN\e[0m][\e[33mY:YELLOW\e[0m][\e[34mB:BLUE\e[0m][\e[36mC:CYAN\e[0m][\e[35mP:PURPLE\e[0m]"
		puts "In the form of #{colorize('R')}#{colorize('G')}#{colorize('Y')}#{colorize('R')}"
		# get the guess
		@guess = gets.strip
	end

	def validate_guess_format(guess)
		# unless guess is proper format
		unless guess.length == 4 && check_colors_format(guess)
			# display error
			return "You have the wrong format"
		end
	end

	def check_colors_format(guess)
	end

end

# the computer that creates the code
class CodeMaker
	include Formats
	attr_reader :code

	def initialize

	end

	def code(possible_colors)
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