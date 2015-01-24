require 'mastermind'

describe Mastermind do

	context "#initialize" do
		it "creates a board instance" do
			expect(subject.board).to_not eq(nil)
		end
		it "creates a code maker" do
			expect(subject.code_maker).to_not eq(nil)
		end
		it "creates a code breaker" do
			expect(subject.code_breaker).to_not eq(nil)
		end
		it "initially sets the turns to 12" do
			expect(subject.turns).to eq(12)
		end
	end

	context "#welcome_player" do
		it "welcomes the player to the game" do
			expect(subject.welcome_player).to eq("Welcome to Mastermind!")
		end
	end


end