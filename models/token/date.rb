module Token
  class Date
    include Token::Base
    include Token::Composite

    WORD_BOUNDARY_REGEXP = /\b/
    MONTH_WORDS = [::Date::MONTHNAMES, ::Date::ABBR_MONTHNAMES].compact
    DAY_WORDS = [::Date::DAYNAMES, ::Date::ABBR_DAYNAMES].compact
    DAY_WORDS_REGEXP = /^(#{DAY_WORDS.join('|')})$/i
    MONTH_WORDS_REGEXP = /^(#{MONTH_WORDS.join('|')})$/i
    ORDINAL_DAY_REGEXP = /^\d{1,2}(?:st|nd|rd|th)$/
    ONE_OR_TWO_DIGIT_REGEXP = /^\d{1,2}$/
    FOUR_DIGIT_YEAR_REGEXP = /^[1-9]\d{3}$/

    private

    def substring_array
      value.split(WORD_BOUNDARY_REGEXP)
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
      else
        Token::String
      end
    end
  end
end
