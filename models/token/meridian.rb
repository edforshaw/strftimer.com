module Token
  class Meridian
    include Token::Base

    UPPERCASE_REGEXP  = /^(AM|PM)$/
    LOWERCASE_REGEXP  = /^(am|pm)$/

    def translation
      case value
      when UPPERCASE_REGEXP
        "%p"
      when LOWERCASE_REGEXP
        "%P"
      end
    end
  end
end
