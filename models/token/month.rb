module Token
  class Month
    include Token::Base

    def translation
      case value.length
      when 1
        "%-m"
      when 2
        "%m"
      end
    end

    def date_group
      :month
    end
  end
end
