module Token
  class Date
    include Token::Base
    include Token::Composite

    WORD_BOUNDARY_REGEXP = /\b/
    DAY_WORDS_REGEXP = /^(#{Constants::DAY_WORDS.join('|')})$/i
    MONTH_WORDS_REGEXP = /^(#{Constants::MONTH_WORDS.join('|')})$/i
    ORDINAL_DAY_REGEXP = /^\d{1,2}(?:st|nd|rd|th)$/
    ONE_OR_TWO_DIGIT_REGEXP = /^\d{1,2}$/
    FOUR_DIGIT_YEAR_REGEXP = /^[1-9]\d{3}$/
    TIMEZONE_REGEXP = /^(#{Constants::TIME_ZONES.join('|')})$/
    EIGHT_DIGIT_REGEXP = /^\d{8}$/

    private

    def substring_array
      if value.match?(EIGHT_DIGIT_REGEXP)  # If a series of digits, split manually
        [value[0..3], value[4..5], value[6..7]]
      else
        value.split(WORD_BOUNDARY_REGEXP)
      end
    end

    def token_class(substring)
      case substring
      when MONTH_WORDS_REGEXP
        Token::MonthWord
      when DAY_WORDS_REGEXP
        Token::DayWord
      when FOUR_DIGIT_YEAR_REGEXP
        Token::Year
      when ORDINAL_DAY_REGEXP
        Token::OrdinalDay
      when ONE_OR_TWO_DIGIT_REGEXP
        Token::NumericalDate
      when TIMEZONE_REGEXP
        Token::Timezone
      else
        Token::String
      end
    end
  end
end
