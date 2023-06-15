module Token
  class Timezone
    include Token::Base

    def translation
      "%Z"
    end
  end
end
