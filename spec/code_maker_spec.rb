require 'mastermind'
describe CodeMaker do

	describe "#code" do

		before do
			@colors = %w(R G B Y C P)
		end

		it "should create a code" do
			expect(subject.code(@colors).length).not_to be(0)
		end

		it "should be four pegs long" do
			expect(subject.code(@colors).length).to be(4)
		end
		it "should contain only appropriate colors" do
			secret_code = subject.code(@colors)
			secret_code.each do |peg|
				expect(@colors).to include(peg[0])
			end
		end

		it "should be different every time" do
			expect(subject.code(@colors)).not_to eq(subject.code(@colors))
		end
	end
end