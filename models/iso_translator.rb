class IsoTranslator
  ISO_REGEXP = %r{\d{4}\-?\d{2}\-?\d{2}T\d{2}:?\d{2}:?\d{2}(?:\.\d{3})?
    ((?:\+|\-)\d{2}:?\d{2}|#{Constants::TIME_ZONES.join('|')}|Z)}xi

  def initialize(query)
    @query = query
  end

  def translation
    @_translation ||= build_translation
  end

  private

  attr_reader :query

  def build_translation
    query.gsub(ISO_REGEXP) { |token| Token::Iso.new(token).translation }
  end
end
