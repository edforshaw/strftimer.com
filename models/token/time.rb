module Token
  class Time
    include Token::Base
    include Token::Composite

    MERIDIAN_REGEXP = /(?:am|pm)/i
    ONE_DIGIT_REGEXP = /^\d{1}$/
    TWO_DIGIT_REGEXP = /^\d{2}$/
    THREE_DIGIT_REGEXP = /^\d{3}$/
    SIX_DIGIT_REGEXP = /^\d{6}$/
    MILITARY_TIME_REGEXP = /^0\d[0-5]\d$/
    WORD_BOUNDARY_REGEXP = /\b/
    TIMEZONE_OFFSET_REGEXP = /^(?:\+|\-)[01]\d:?\d{2}$/

    private

    def substring_array
      case value
      when SIX_DIGIT_REGEXP # If a series of digits, split manually
        [value[0..1], value[2..3], value[4..5]]
      when TIMEZONE_OFFSET_REGEXP # No need to split timezone offsets
        [value]
      else
        # Ideally we could just split by the word boundary regexp, but we also
        # need to partition by meridian. For example, to break up "12pm".
        value.partition(MERIDIAN_REGEXP).collect do |substring|
          substring.split(WORD_BOUNDARY_REGEXP)
        end.flatten
      end
    end

    def token_class(substring)
      case substring
      when MERIDIAN_REGEXP
        Token::Meridian
      when ONE_DIGIT_REGEXP
        Token::Hour
      when TWO_DIGIT_REGEXP
        Token::TwoDigitTime
      when THREE_DIGIT_REGEXP
        Token::Millisecond
      when TIMEZONE_OFFSET_REGEXP
        Token::TimezoneOffset
      when MILITARY_TIME_REGEXP
        Token::MilitaryTime
      else
        Token::String
      end
    end
  end
end
