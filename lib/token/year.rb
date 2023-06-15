module Token
  class Year
    include Token::Base

    def translation
      case value.length
      when 2
        "%y"
      when 4
        "%Y"
      end
    end

    def date_group
      :year
    end
  end
end
