module Token
  class Iso
    include Token::Base
    
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
    DATE_REGEXP = /\d{4}(?:-)?\d{2}(?:-)?\d{2}/
    TIME_REGEXP = /\d{2}(?::)?\d{2}(?::)?\d{2}(?:\.\d{3,})?/
    TIMEZONE_ABBR_REGEXP = /(#{TIME_ZONES.join('|')})/
    TIMEZONE_OFFSET_REGEXP = /(?:\+|-)\d{2}:?\d{2}/
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
