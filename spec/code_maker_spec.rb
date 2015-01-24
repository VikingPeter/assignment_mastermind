require 'mastermind'
describe CodeMaker do

	describe "#code" do

		before(:example) do
			@colors = %w(R G B Y C P)
		end

		it "should create a code" do
			expect(subject.code.length).not_to be(nil)
		end

		it "should be four pegs long" do
			expect(subject.code.length).to be(4)
		end
		it "should contain only appropriate colors" do
			secret_code = subject.code
			secret_code.each do |peg|
				expect(@colors).to include(peg[0])
			end
		end

		it "should be different every time" do
			secret_code = subject.code
			expect(CodeMaker.new.code).not_to eq(secret_code)
		end
	end
end