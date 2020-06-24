module Token
  module Base
    def self.included(base)
      base.class_eval do
        def initialize(value)
          @value = value
        end
      end
    end

    def translation
      value
    end

    def contextualize(previous_tokens:, next_tokens:)
    end

    private

    attr_reader :value
  end
end
