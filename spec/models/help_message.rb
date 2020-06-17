require './strftimer'

describe HelpMessage do
  describe "#message" do
    it "returns nil if no message is required" do
      help = described_class.new("%m %d %Y")
      expect(help.message).to be_empty
    end

    it "returns a message if help text is required" do
      help = described_class.new("\#{mytime.day.ordinalize} %m %Y")
      expect(help.message).to_not be_empty
    end
  end
end
