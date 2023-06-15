module Token
  class MilitaryTime
    include Token::Base

    def translation
      valid_time? ? "%H%M" : value
    end

    private

    def valid_time?
      hour.between?(0, 23) && minute.between?(0, 59)
    end

    def hour
      value[0..1].to_i
    end

    def minute
      value[2..3].to_i
    end
  end
end
