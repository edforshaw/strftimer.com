module Token
  class DayWord
    include Token::Base

    DAY_NAME = /^(#{::Date::DAYNAMES.join('|')})$/i
    ABBR_DAY_NAME = /^(#{::Date::ABBR_DAYNAMES.join('|')})$/i

    def translation
      ["%", case_directive, letter_directive].join
    end

    private

    def case_directive
      "^" if value == value.upcase
    end

    def letter_directive
      case value
      when DAY_NAME
        "A"
      when ABBR_DAY_NAME
        "a"
      end
    end
  end
end
