require 'mastermind'
describe Board do

	it "is creates an empty board array" do
		expect(subject.board).to eq([nil, nil, nil, nil])
	end

	describe '#render' do
		it "should render four response pegs" do
		end

		it "should render 'white' pegs for correct color,  wrong postition"
		it "should render 'black' pegs for correct color, correct postition"
		it "should render 'X' pegs for wrong color, wrong position"
		it "should render 'You Win!' when a player wins"
		it "should render 'You are a loser' when the player loses"
	end

	describe "#colorize" do
		it "should return the proper ANSI formated string"
	end

	describe "#check_guess" do
		it "should check each peg in the guess"
	end

end
