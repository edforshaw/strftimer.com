module Token
  class FractionalSecond
    include Token::Base

    def translation
      if value.length == 3
        "%L"
      else
        "%#{value.length}N"
      end
    end
  end
end
