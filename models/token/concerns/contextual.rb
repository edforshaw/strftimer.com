# A contextual token needs to know about the surrounding
# token it in order to determine its translation.
module Token
  module Contextual
    def contextualize(previous_tokens:, next_tokens:)
      @previous_tokens = previous_tokens
      @next_tokens = next_tokens
      contextual_token
    end

    private

    attr_reader :previous_tokens, :next_tokens

    def contextual_token
      new_token = contextual_token_class.new(value)
      new_token.contextualize(previous_tokens: previous_tokens, next_tokens: next_tokens)
      new_token
    end

    def tokens_include?(klass)
      tokens.any? { |token| token.is_a?(klass) }
    end

    def tokens
      previous_tokens + next_tokens
    end
  end
end
