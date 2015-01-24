require 'mastermind'
require 'stringio'

describe CodeBreaker do

	subject(:code_breaker) {CodeBreaker.new}

	# need help with IO tests
	# describe "#ask_for_guess" do
	# 	before do
	# 	  $stdin = StringIO.new("rRgR")
	# 	end

	# 	after do
	# 		$stdin = STDIN
	# 	end

	# 	it "should clean up the guess format" do

	# 		binding.pry
	# 		expect(subject.ask_for_guess).to eq(["R", "R", "G", "R"])
	# 	end
	# 	it "should return an error if format is not acceptable"
	# 	it "should break loop if guess format acceptable" # is this sketchy?
	# end

	describe "#validate_response_format" do

		it "return false if the response is not formated correctly" do
			expect(subject.validate_response_format(123)).to eq(false)
			expect(subject.validate_response_format(1234)).to eq(false)
		end
	end

	describe "check_colors_format" do
		it "should check if the pegs are included in the set of colors" do
	  	expect(subject.check_colors_format("rrrr", ["R","G", "B"]))
	  	expect(subject.check_colors_format("gggg", ["R","G", "B"]))
		end
	end

end
