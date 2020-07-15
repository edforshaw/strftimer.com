class TimeTranslator
  GLOBAL_TIME_REGEXP = %r{(\d{1,2}:\d{2}\s*(?:\:\d{2})?\s*(?:(\.|:)\d{3,})?\s*(?:am|pm)?)|
    (\d{1,2}(?:am|pm))|(0\d{3})|((\+|\-)[01]\d:?\d{2})}xi

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
