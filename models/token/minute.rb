module Token
  class Minute
    include Token::Base

    def translation
      "%M"
    end
  end
end
