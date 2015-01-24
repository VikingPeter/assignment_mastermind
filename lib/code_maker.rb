require_relative 'formats'

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
		until (random_code.length == 4) do
			peg = possible_colors.sample(1)[0]
			random_code << peg unless random_code.include?(peg)
		end
		return random_code
	end
end