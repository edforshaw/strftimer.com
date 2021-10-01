require './strftimer'

describe Translator do
  describe "#valid?" do
    it "returns false if there is no query" do
      translator = described_class.new("")
      expect(translator).to_not be_valid
    end

    it "returns false if no translation has taken place" do
      translator = described_class.new("foobar")
      expect(translator).to_not be_valid
    end

    it "returns true if a translation can take place" do
      translator = described_class.new("25 December 2020")
      expect(translator).to be_valid
    end
  end

  # As this is the only entrypoint into the translation logic,
  # use this method to test all our translations.
  describe "#translate" do
    [
      ["January", "%B"],
      ["Jan", "%b"],
      ["SEPTEMBER", "%^B"],
      ["DEC", "%^b"],

      ["Tuesday", "%A"],
      ["Tue", "%a"],
      ["SUNDAY", "%^A"],
      ["FRI", "%^a"],

      ["2020", "%Y"],
      ["January 2020", "%B %Y"],
      ["Jan 2020", "%b %Y"],

      ["0800", "%H%M"],
      ["0959", "%H%M"],

      ["01:13", "%H:%M"],
      ["10:13", "%H:%M"],
      ["1:13", "%-k:%M"],

      ["10:13pm", "%I:%M%P"],
      ["01:13pm", "%I:%M%P"],
      ["1:13pm", "%-l:%M%P"],
      ["1:13PM", "%-l:%M%p"],
      ["10:13 pm", "%I:%M %P"],
      ["1:13 pm", "%-l:%M %P"],
      ["1pm", "%-l%P"],
      ["08am", "%I%P"],
      ["5PM", "%-l%p"],

      ["1st", "\#{mytime.day.ordinalize}"],
      ["1st Jan", "\#{mytime.day.ordinalize} %b"],
      ["1st January", "\#{mytime.day.ordinalize} %B"],
      ["1st Jan 2020", "\#{mytime.day.ordinalize} %b %Y"],
      ["1st January 2020", "\#{mytime.day.ordinalize} %B %Y"],
      ["January 1st 2020", "%B \#{mytime.day.ordinalize} %Y"],
      ["Tue 1st January 2020", "%a \#{mytime.day.ordinalize} %B %Y"],
      ["Tuesday 1st January 2020", "%A \#{mytime.day.ordinalize} %B %Y"],
      ["Tuesday, 1st January 2020", "%A, \#{mytime.day.ordinalize} %B %Y"],
      ["Mon 31st DEC", "%a \#{mytime.day.ordinalize} %^b"],

      ["1 Jan", "%-d %b"],
      ["01 Jan", "%d %b"],
      ["12 Jan", "%d %b"],

      ["Jan 13", "%b %y"],
      ["Jan 09", "%b %y"],
      ["January 13", "%B %y"],
      ["January 09", "%B %y"],

      ["1 Jan 13", "%-d %b %y"],
      ["13 Jan 13", "%d %b %y"],
      ["01 Jan 13", "%d %b %y"],
      ["1 Jan 2013", "%-d %b %Y"],
      ["13 Jan 2013", "%d %b %Y"],
      ["01 Jan 2013", "%d %b %Y"],

      ["1 January 13", "%-d %B %y"],
      ["13 January 13", "%d %B %y"],
      ["01 January 13", "%d %B %y"],
      ["1 January 2020", "%-d %B %Y"],
      ["13 January 2013", "%d %B %Y"],
      ["01 January 2013", "%d %B %Y"],
      ["2013 January 2", "%Y %B %-d"],

      ["01/01/2013", "%d/%m/%Y"],
      ["1/01/2013", "%-d/%m/%Y"],
      ["10/10/2013", "%d/%m/%Y"],
      ["10/13/2013", "%m/%d/%Y"],
      ["1/13/2013", "%-m/%d/%Y"],
      ["01/13/2013", "%m/%d/%Y"],
      ["01/12/2013", "%d/%m/%Y"],
      ["01/1/2013", "%d/%-m/%Y"],
      ["1/9/2013", "%-d/%-m/%Y"],
      ["1/1/2013", "%-d/%-m/%Y"],
      ["13/1/2013", "%d/%-m/%Y"],
      ["13/01/2013", "%d/%m/%Y"],
      ["10/22/18", "%m/%d/%y"],

      ["01/01/13", "%d/%m/%y"],
      ["01-01-2013", "%d-%m-%Y"],
      ["01.01.2013", "%d.%m.%Y"],

      ["2013/01/01", "%Y/%m/%d"],
      ["2013/9/1", "%Y/%-m/%-d"],
      ["2013-01-01", "%Y-%m-%d"],

      ["01:13:21", "%H:%M:%S"],
      ["10:13:21", "%H:%M:%S"],
      ["1:13:21", "%-k:%M:%S"],

      ["10:13:21pm", "%I:%M:%S%P"],
      ["01:13:21pm", "%I:%M:%S%P"],
      ["1:13:21pm", "%-l:%M:%S%P"],
      ["1:13:21PM", "%-l:%M:%S%p"],
      ["10:13:21 pm", "%I:%M:%S %P"],
      ["1:13:21 pm", "%-l:%M:%S %P"],
      ["02:35:46 PM", "%I:%M:%S %p"],
      ["10:13:21.000pm", "%I:%M:%S.%L%P"],
      ["10:13:21.000111pm", "%I:%M:%S.%6N%P"],
      ["10:13:21.1234567pm", "%I:%M:%S.%7N%P"],

      ["23 Jun 2020 at 18:10 BST", "%d %b %Y at %H:%M %Z"],
      ["23 Jun 2020 at 18:10 FOO", "%d %b %Y at %H:%M FOO"],
      ["1:23pm CEST", "%-l:%M%P %Z"],
      ["Jun 24, 2020 01:23:45 PM", "%b %d, %Y %I:%M:%S %p"],

      ["1:11:11:111", "%-k:%M:%S:%L"],
      ["2019-12-31 12:24:02.999", "%Y-%m-%d %H:%M:%S.%L"],
      ["12:24:02.999 pm", "%I:%M:%S.%L %P"],
      ["11:52 26 Jun 2020", "%H:%M %d %b %Y"],
      ["Mon, 29 Jun 2020 12:34:56 +09:00", "%a, %d %b %Y %H:%M:%S %:z"],
      ["Wed, 15 Jul 2020 12:34:56.00112233 +09:00", "%a, %d %b %Y %H:%M:%S.%8N %:z"],

      ["2020-06-26T15:39:30Z", "%Y-%m-%dT%H:%M:%SZ"],
      ["2020-06-26T16:40:00.000Z", "%Y-%m-%dT%H:%M:%S.%LZ"],
      ["2020-07-10T12:34:56.789", "%Y-%m-%dT%H:%M:%S.%L"],
      ["2020-06-26T16:40:00.000-0100", "%Y-%m-%dT%H:%M:%S.%L%z"],
      ["2020-06-26T16:40:00.000-01:00", "%Y-%m-%dT%H:%M:%S.%L%:z"],
      ["2020-06-26T16:40:00.000+00:00", "%Y-%m-%dT%H:%M:%S.%L%:z"],
      ["2020-01-06T15:15:48-02:00", "%Y-%m-%dT%H:%M:%S%:z"],
      ["2020-01-01T00:00:00+0000", "%Y-%m-%dT%H:%M:%S%z"],
      ["2020-06-26T16:40:00.000UTC", "%Y-%m-%dT%H:%M:%S.%L%Z"],
      ["20200626T153930Z", "%Y%m%dT%H%M%SZ"],
      ["2020-07-14T11:11:11.123456", "%Y-%m-%dT%H:%M:%S.%6N"],
      ["2020-07-14T11:11:11.123456789+03:00", "%Y-%m-%dT%H:%M:%S.%9N%:z"],

      ["", ""],
      ["some text", "some text"],
      ["the %year is %2020%", "the %%year is %%%Y%%"],
    ].each do |input, expected_output|
      it "given input \"#{input}\" it returns \"#{expected_output}\"" do
        translator = described_class.new(input)
        expect(translator.translation).to eq(expected_output)
      end
    end
  end
end
