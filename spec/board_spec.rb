require 'mastermind'
describe Board do

	it "creates an empty board array" do
		expect(subject.board).to be_a(Array)
	end

	describe '#render' do
		it "should render the entire board to output" do
			expect(subject.render)
		end
	end

	describe "#generate_result" do
		before(:example) do
			@code = ["R","G","B","Y"]
		end
		it "should generate the result of the round" do
			guess = ["R","G","B","Y"]
			expect(subject.generate_result(guess, @code)).not_to be_nil
		end
		it "generates the result for perfect match" do
			guess = ["R","G","B","Y"]
			expect(subject.generate_result(guess, @code)).to eq(@code)
		end
		it "generates the result for a right color right place" do
			guess_1 = ["R","C","C","C"]
			guess_2 = ["C","G","C","C"]
			guess_3 = ["C","C","B","C"]
			guess_4 = ["C","C","C","Y"]
			expect(subject.generate_result(guess_1, @code)[0]).to eq("R")
			expect(subject.generate_result(guess_2, @code)[1]).to eq("G")
			expect(subject.generate_result(guess_3, @code)[2]).to eq("B")
			expect(subject.generate_result(guess_4, @code)[3]).to eq("Y")
		end
		it "generates the result for a right color wrong place" do
			guess_1 = ["C","R","C","C"]
			guess_2 = ["C","C","G","C"]
			guess_3 = ["C","C","C","B"]
			guess_4 = ["Y","C","C","C"]
			expect(subject.generate_result(guess_1, @code)[1]).to eq("W")
			expect(subject.generate_result(guess_2, @code)[2]).to eq("W")
			expect(subject.generate_result(guess_3, @code)[3]).to eq("W")
			expect(subject.generate_result(guess_4, @code)[0]).to eq("W")
		end

		it "generates the result for a wrong color" do
			guess_1 = ["C","R","B","Y"]
			guess_2 = ["R","C","B","Y"]
			guess_3 = ["R","G","C","Y"]
			guess_4 = ["R","G","B","C"]
			expect(subject.generate_result(guess_1, @code)).to eq(["X","R","B","Y"])
			expect(subject.generate_result(guess_2, @code)).to eq(["R","X","B","Y"])
			expect(subject.generate_result(guess_3, @code)).to eq(["R","G","X","Y"])
			expect(subject.generate_result(guess_4, @code)).to eq(["R","G","B","X"])
		end

		it "handles repeats" do
			code = ["P", "G", "P", "B"]
			guess_0 = ["P","G","P","B"]
			guess_1 = ["P","C","C","C"]
			guess_2 = ["C","C","P","C"]
			guess_3 = ["P","C","P","C"]
			guess_4 = ["P","C","P","P"]
			expect(subject.generate_result(guess_0, code)).to eq(["P","G","P","B"])
			expect(subject.generate_result(guess_1, code)).to eq(["P","G","P","B"])
			expect(subject.generate_result(guess_2, code)).to eq(["R","X","B","Y"])
			expect(subject.generate_result(guess_3, code)).to eq(["R","G","X","Y"])
			expect(subject.generate_result(guess_4, code)).to eq(["R","G","B","X"])
		end
	end

	describe "#win?" do
	  it "should check the result for a win" do
	  	expect(subject.win?(1,1)).to eq(true)
	  	expect(subject.win?(1,2)).to eq(false)
	  end
	end


end
