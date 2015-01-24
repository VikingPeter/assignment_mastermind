require_relative 'formats'

# the game state
class Board

	include Formats

	attr_reader :result, :board

	def initialize
		# create an empty array to hold the result of each checked guess
		@board = Array.new
	end

	def render
		# loop through the board array and display the result using colorize
			if (@board.length > 0)
				puts "Board rendered"
				print "turn || move\n"
				@board.each_with_index do |result, turn|
					print "#{turn+1}. "
					result.each { |peg| print "#{colorize(peg)}" }
					print "\n"
				end
			end
	end

	def win?(guess, code)
		guess == code
	end

	# this generates a result to the board. It doesn't run if the user
	# has already won
	# this should definitely be broken into more methods. It got away from me
	def generate_result(guess, code)
		@result = []
		# return the guess exactly if there is a match

		if (win?(guess, code))
			@result = guess
			return @result
		else
			# for each peg in guess
			guess.each_with_index do |guess_peg, guess_index|
				# compare against secret code
				code.each_with_index do |code_peg, code_index|
					# if both color(peg) and position(index) match
					if perfect_peg(guess_peg, code_peg, guess_index, code_index)
						# save the peg in that position
						@result[guess_index] = code_peg
						break
					# if only color matches any other position
					elsif close_guess(guess_peg, code_peg, guess_index, code_index)
						# save a WHITE(W) peg in that postion
						@result[guess_index] = "W"
						break
					# if there is no match
					else
						# put an X in that position
						@result[guess_index] = "X"
					end
				end
			end
		end
		# push the result to the board where you can use it for rendering
		@board.push(@result)
		# return the result to use directly
		return @result
	end

	def miss(guess_peg, code_peg)
		guess_peg != code_peg
	end

	def close_guess(guess_peg, code_peg, guess_index, code_index)
		(guess_peg == code_peg) && (guess_index != code_index)
	end

	def perfect_peg(guess_peg, code_peg, guess_index, code_index)
		(guess_peg == code_peg) && (guess_index == code_index)
	end

end
