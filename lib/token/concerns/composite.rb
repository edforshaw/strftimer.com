# A composite token consists of sub tokens which
# need to be contextualised before translation
module Token
  module Composite
    def translation
      contextual_sub_tokens.collect(&:translation).join
    end

    def contextual_sub_tokens
      current_tokens = []

      # We must first have the base tokens in place before we
      # can determine what they should actually be in the context
      # of their previous and next siblings.
      base_sub_tokens.each_with_index.collect do |token, index|
        current_tokens << if token.is_a?(Token::Contextual)
                            token.contextualize(
                              previous_tokens: current_tokens,
                              next_tokens: next_base_tokens(index)
                            )
                          else
                            token
                          end
      end

      current_tokens
    end

    def next_base_tokens(index)
      base_sub_tokens[index + 1..-1] || []
    end

    def base_sub_tokens
      substring_array.collect do |substring|
        token_class(substring).new(substring)
      end
    end
  end
end
