require_relative 'formats'

# the human player
class CodeBreaker

	include Formats

	attr_accessor :guess

	def initialize
	end

	def ask_for_guess
		loop do
			# this is terrible naming - I am is confused
			response = $stdin.gets.strip
			if (validate_response_format(response))
				@guess = response.split(//).map(&:upcase)
				break
			else
				puts "You need to format as four sequential colors"
			end
		end
	end

	# implement this in Mastermind
	# def check_quit(response)
	# 	response.length.times do |i|
	# 		response[i].downcase
	# 	end
	# 	response == "q" ||
	# 	response == "quit" ||
	# 	response == "exit"
	# end

	def validate_response_format(response)
		# unless response is proper format
		(response.size == 4) && (check_colors_format(response, POSSIBLE_COLORS))
	end

	def check_colors_format(response, colors)
		response.split(//).all? do |peg|
			colors.include?(peg.upcase)
		end
	end

end