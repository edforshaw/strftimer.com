module Token
  class MonthWord
    include Token::Base

    MONTH_NAME = /^(#{::Date::MONTHNAMES.compact.join('|')})$/i
    ABBR_MONTH_NAME = /^(#{::Date::ABBR_MONTHNAMES.compact.join('|')})$/i

    def translation
      ["%", case_directive, letter_directive].join
    end

    def date_group
      :month
    end

    private

    def case_directive
      "^" if value == value.upcase
    end

    def letter_directive
      case value
      when MONTH_NAME
        "B"
      when ABBR_MONTH_NAME
        "b"
      end
    end
  end
end
