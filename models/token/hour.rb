module Token
  class Hour
    include Token::Base
    include Token::Contextual

    def translation
      case value.length
      when 1
        meridian_present? ? "%-l" : "%-k"
      when 2
        meridian_present? ? "%I" : "%H"
      end
    end

    def contextualize(previous_tokens:, next_tokens:)
      @previous_tokens = previous_tokens
      @next_tokens = next_tokens
      self
    end

    private

    def meridian_present?
      tokens_include?(Token::Meridian)
    end
  end
end
