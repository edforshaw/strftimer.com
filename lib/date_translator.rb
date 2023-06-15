require "token/date"

class DateTranslator
  def initialize(query)
    @query = query
  end

  def translation
    Token::Date.new(query).translation
  end

  private

  attr_reader :query
end
