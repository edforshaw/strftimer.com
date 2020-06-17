module Token
  class Time
    include Token::Base
    include Token::Composite

    MERIDIAN_REGEXP = /(?:am|pm)/i
    ONE_DIGIT_REGEXP = /^\d{1}$/
    TWO_DIGIT_REGEXP = /^\d{2}$/
    MILITARY_TIME_REGEXP = /^0\d[0-5]\d$/
    WORD_BOUNDARY_REGEXP = /\b/

    private

    # Ideally we could just split by the word boundary regexp, but we also
    # need to partition by meridian. For example, to break up "12pm".
    def substring_array
      value.partition(MERIDIAN_REGEXP).collect do |substring|
        substring.split(WORD_BOUNDARY_REGEXP)
      end.flatten
    end

    def token_class(substring)
      case substring
      when MERIDIAN_REGEXP
        Token::Meridian
      when ONE_DIGIT_REGEXP
        Token::Hour
      when TWO_DIGIT_REGEXP
        Token::TwoDigitTime
      when MILITARY_TIME_REGEXP
        Token::MilitaryTime
      else
        Token::String
      end
    end
  end
end
