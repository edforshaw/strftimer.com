class TimeTranslator
  GLOBAL_TIME_REGEXP = /(\d{1,2}:\d{2}\s*:?\d{2}?\s*(?:am|pm)?)|(\d{1,2}(?:am|pm))|(0\d{3})/i

  def initialize(query)
    @query = query
  end

  def translation
    @_translation ||= build_translation
  end

  private

  attr_reader :query

  def build_translation
    query.gsub(GLOBAL_TIME_REGEXP) { |token| Token::Time.new(token).translation }
  end
end
