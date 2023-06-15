module Token
  class TimezoneOffset
    include Token::Base

    def translation
      value.include?(":") ? "%:z" : "%z"
    end
  end
end
