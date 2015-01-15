require 'mastermind'
describe Board do

	it "is creates an empty board array" do
		expect(subject.board).to eq([nil, nil, nil, nil])
	end

	describe '#render' do
		it "should render the board to output"	end

	describe "#check_guess" do
		it "should check each peg in the guess"
	end

	describe "#generate_result" do
		it "should generate the result of the round"
	end

	describe "#win?" do
	  it "should check the result for a win"
	end


end
