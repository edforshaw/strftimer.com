module Token
  class TwoDigitTime
    include Token::Base
    include Token::Contextual

    private

    def contextual_token_class
      [Token::Hour, Token::Minute, Token::Second].each do |klass|
        return klass unless tokens_include?(klass)
      end

      Token::String
    end
  end
end
