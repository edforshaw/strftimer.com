module Token
  class Iso
    include Token::Base
    DATE_REGEXP = /\d{4}(?:\-)?\d{2}(?:\-)?\d{2}/
    TIME_REGEXP = /\d{2}(?:\:)?\d{2}(?:\:)?\d{2}(?:\.\d{3})?/
    TIMEZONE_REGEXP = /(#{Constants::TIME_ZONES.join('|')})/
    TIMEZONE_OFFSET_REGEXP = /(?:\+|\-)\d{2}\:?\d{2}/

    def translation
      [
        date_translation,
        "T",
        time_translation,
        (timezone_translation || timezone_offset_translation || "Z")
      ].join
    end

    private

    def date_translation
      Token::Date.new(value.scan(DATE_REGEXP).first).translation
    end

    def time_translation
      Token::Time.new(value.scan(TIME_REGEXP).first).translation
    end

    def timezone_translation
      if (str = value.scan(TIMEZONE_REGEXP).first)
        Token::Timezone.new(str).translation
      end
    end

    def timezone_offset_translation
      if (str = value.scan(TIMEZONE_OFFSET_REGEXP).first)
        Token::TimezoneOffset.new(str).translation
      end
    end
  end
end
