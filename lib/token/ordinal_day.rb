module Token
  class OrdinalDay
    include Token::Base
    DIRECTIVE = "\#{mytime.day.ordinalize}"

    def translation
      DIRECTIVE
    end

    def date_group
      :day
    end
  end
end
