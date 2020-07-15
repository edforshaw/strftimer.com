module Token
  class Iso
    include Token::Base
    DATE_REGEXP = /\d{4}(?:\-)?\d{2}(?:\-)?\d{2}/
    TIME_REGEXP = /\d{2}(?:\:)?\d{2}(?:\:)?\d{2}(?:\.\d{3,})?/
    TIMEZONE_ABBR_REGEXP = /(#{Constants::TIME_ZONES.join('|')})/
    TIMEZONE_OFFSET_REGEXP = /(?:\+|\-)\d{2}\:?\d{2}/
    TIMEZONE_FALLBACK_REGEXP = /Z$/

    def translation
      [
        date_translation,
        "T",
        time_translation,
        timezone_translation
      ].join
    end

    private

    def date_translation
      Token::Date.new(value[DATE_REGEXP]).translation
    end

    def time_translation
      Token::Time.new(value[TIME_REGEXP]).translation
    end

    def timezone_translation
      case value
      when TIMEZONE_ABBR_REGEXP
        Token::Timezone.new(value[TIMEZONE_ABBR_REGEXP]).translation
      when TIMEZONE_OFFSET_REGEXP
        Token::TimezoneOffset.new(value[TIMEZONE_OFFSET_REGEXP]).translation
      when TIMEZONE_FALLBACK_REGEXP
        Token::String.new(value[TIMEZONE_FALLBACK_REGEXP]).translation
      end
    end
  end
end
