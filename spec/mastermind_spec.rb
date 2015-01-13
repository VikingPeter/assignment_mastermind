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
			expect(subject.welcome_player).to eq("\nWelcome to Mastermind!")
		end
	end

	context "#check_victory" do
		it "returns a win message when there is a win" do
			allow(subject.board).to receive(:win?){true}
			expect(subject.check_victory).to eq("Oh. You won... Congrats, I guess")
		end
		it "doesn't display a message when ther is no win" do
			expect(subject.check_victory).to be(nil)
		end
	end

	context "#check_loss" do
		it "returns message if game is lost" do
			allow(subject).to receive(:turns){0}
			expect(subject.check_loss).to eq("You have lost the game")
		end
		it "returns nil if turns is > 0" do
			expect(subject.check_loss).to be(nil)
		end
	end

end