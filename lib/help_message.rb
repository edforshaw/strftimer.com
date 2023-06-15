class HelpMessage
  def initialize(translation)
    @translation = translation
  end

  def message
    @_message = build_message
  end

  private

  attr_reader :translation

  def build_message
    all.collect do |directive, message|
      message if translation.include?(directive)
    end.compact.join
  end

  def all
    {
      Token::OrdinalDay::DIRECTIVE => ordinal_message
    }
  end

  # Ugly, but we will remove content from this class if
  # any more messages are added.
  def ordinal_message
    "<strong>ordinalize</strong> method available with
     <a href=\"https://github.com/rails/rails/tree/master/activesupport\">
       ActiveSupport
     </a>"
  end
end
