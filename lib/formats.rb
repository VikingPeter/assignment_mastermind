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
			when "W"
				color_code = 37
			else
				color_code = 4;37
		end
		print "\e[#{color_code}m#{text}\e[0m"
	end
end