require 'mastermind'
describe CodeBreaker do

	subject(:code_breaker) {CodeBreaker.new}

	describe "#get_guess" do

		it "should ask_for_guess"
		it "should validate_guess_format"
		it "should break loop if guess format acceptable" # is this sketchy?

	end

	describe "#ask_for_guess" do

		it "should display the guess prompt"
		it "should set the guess to an instance variable"

	end

	describe "#validate_guess_format" do

		it "should display an error if the guess is not formated correctly"

	end

end
