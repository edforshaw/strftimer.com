require "token/concerns/base"
require "token/concerns/composite"
require "token/concerns/contextual"
require "token/string"
require "token/year"
require "token/iso"
require "token/numerical_date"
require "token/day"
require "token/month"
require "token/time"
require "token/two_digit_time"
require "token/fractional_second"
require "token/minute"
require "token/hour"
require "token/second"
require "token/meridian"
require "token/timezone_offset"
require "token/timezone"
require "token/day_word"
require "token/month_word"
require "token/ordinal_day"
require "token/military_time"

module Token
  class Date
    include Token::Base
    include Token::Composite

    DAY_WORDS = [::Date::DAYNAMES, ::Date::ABBR_DAYNAMES].compact
    MONTH_WORDS = [::Date::MONTHNAMES, ::Date::ABBR_MONTHNAMES].compact
    TIME_ZONES = %w[
      ACDT ACST ACT ACWST ADT AEDT AEST AET AFT AKDT AKST ALMT AMST AMT ANAT
      AQTT ART AST AWST AZOST AZOT AZT BDT BIOT BIT BOT BRST BRT BST BTT CAT
      CCT CDT CEST CET CHADT CHAST CHOT CHOST CHST CHUT CIST CIT CKT CLST CLT
      COST COT CST CT CVT CWST CXT DAVT DDUT DFT EASST EAST EAT ECT EDT EEST
      EET EGST EGT EIT EST FET FJT FKST FKT FNT GALT GAMT GET GFT GILT GIT GMT
      GST GYT HDT HAEC HST HKT HMT HOVST HOVT ICT IDLW IDT IOT IRDT IRKT IRST
      IST JST KALT KGT KOST KRAT KST LHST LINT MAGT MART MAWT MDT MET MEST MHT
      MIST MIT MMT MSK MST MUT MVT MYT NCT NDT NFT NOVT NPT NST NT NUT NZDT
      NZST OMST ORAT PDT PET PETT PGT PHOT PHT PKT PMDT PMST PONT PST PYST PYT
      RET ROTT SAKT SAMT SAST SBT SCT SDT SGT SLST SRET SRT SST SYOT TAHT THA
      TFT TJT TKT TLT TMT TRT TOT TVT ULAST ULAT UTC UYST UYT UZT VET VLAT VOLT
      VOST VUT WAKT WAST WAT WEST WET WIT WGST WGT WST YAKT YEKT
    ]

    WORD_BOUNDARY_REGEXP = /\b/
    DAY_WORDS_REGEXP = /^(#{DAY_WORDS.join('|')})$/i
    MONTH_WORDS_REGEXP = /^(#{MONTH_WORDS.join('|')})$/i
    ORDINAL_DAY_REGEXP = /^\d{1,2}(?:st|nd|rd|th)$/
    ONE_OR_TWO_DIGIT_REGEXP = /^\d{1,2}$/
    FOUR_DIGIT_YEAR_REGEXP = /^[1-9]\d{3}$/
    TIMEZONE_ABBR_REGEXP = /^(#{TIME_ZONES.join('|')})$/
    EIGHT_DIGIT_REGEXP = /^\d{8}$/

    private

    def substring_array
      if value.match?(EIGHT_DIGIT_REGEXP)  # If a series of digits, split manually
        [value[0..3], value[4..5], value[6..7]]
      else
        value.split(WORD_BOUNDARY_REGEXP)
      end
    end

    def token_class(substring)
      case substring
      when MONTH_WORDS_REGEXP
        Token::MonthWord
      when DAY_WORDS_REGEXP
        Token::DayWord
      when FOUR_DIGIT_YEAR_REGEXP
        Token::Year
      when ORDINAL_DAY_REGEXP
        Token::OrdinalDay
      when ONE_OR_TWO_DIGIT_REGEXP
        Token::NumericalDate
      when TIMEZONE_ABBR_REGEXP
        Token::Timezone
      else
        Token::String
      end
    end
  end
end
