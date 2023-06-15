class EscapeTranslator
  ESCAPE_REGEXP = /%/

  def initialize(query)
    @query = query
  end

  def translation
    @_translation ||= build_translation
  end

  private

  attr_reader :query

  def build_translation
    query.gsub(ESCAPE_REGEXP) { "%%" }
  end
end
