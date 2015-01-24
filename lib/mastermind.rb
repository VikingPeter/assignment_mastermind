require 'pry'
require_relative 'board'
require_relative 'code_maker'
require_relative 'code_breaker'
require_relative 'formats'

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

		while (@turns > 0) # refactor to a while that automatically ends in loss?
			# render the board
			board.render
			# get the guess from the code breaker
			@code_breaker.ask_for_guess
			# check the guess against the code
			if board.win?(@code_breaker.guess, @code_maker.code)
				puts "YES! YOU WIN!\n"
				break
			end
			board.generate_result(@code_breaker.guess, @code_maker.code) # write this in class Board
			# remove one from the turns counter
			@turns -= 1
			puts "LAST GUESS:" if @turns == 10
		end

		puts "YOU LOSE SO HARD!" if @turns == 0
		puts "The SECRET CODE is"
		puts "#{@code_maker.code.each{|p|colorize(p)}}\t\n"
	end

	def welcome_player
		# render the initial message
		return "Welcome to Mastermind!"
	end

	def explain_rules
		puts "Try to beat the computer by guessing the secret code!"
		# display the message prompting first guess
		puts "You can choose a combination of four from:\n[\e[31mR:RED\e[0m][\e[32mG:GREEN\e[0m][\e[33mY:YELLOW\e[0m][\e[34mB:BLUE\e[0m][\e[36mC:CYAN\e[0m][\e[35mP:PURPLE\e[0m]"
		puts "in the form of"
		puts "#{colorize('R')}#{colorize('G')}#{colorize('Y')}#{colorize('R')}\n"
		sleep 0.5
		puts "What is your guess?"
	end


end
