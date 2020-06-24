module Token
  class NumericalDate
    include Token::Base
    include Token::Contextual

    def date_group
      if looks_like_a_year?
        :year
      elsif looks_like_a_day?
        :day
      end
    end

    protected

    def looks_like_a_day?
      value.to_i.between?(13, 31)
    end

    def looks_like_a_year?
      value.to_i > 31
    end

    private

    def contextual_token_class
      token_klass_for(priority_token_group) || Token::String
    end

    def priority_token_group
      prioritised_token_groups.find { |group| !previous_date_groups.include?(group) }
    end

    def prioritised_token_groups
      groups = if looks_like_a_year?
        [:year]
      elsif (klasses_from_next = prioritised_token_groups_from_next)
        klasses_from_next
      elsif (klasses_from_previous = prioritised_token_groups_from_previous)
        klasses_from_previous
      else
        [:day, :month, :year]
      end

      groups.delete(:month) if value.to_i > 12
      groups.delete(:day) if value.to_i > 31
      groups
    end

    # Look ahead at the next date-like tokens to determine this one
    def prioritised_token_groups_from_next
      case next_date_groups
      when [:day, :year]
        [:month, :day, :year]
      when [:day, :day] # or if 2 day-like numbers e.g. "22/18", also prioritise month
        [:month, :day, :year]
      when [:year]
        [:day, :month]
      end
    end

    # Look behind at the previous date-like tokens to determine this one
    def prioritised_token_groups_from_previous
      case previous_date_groups
      when [:year]
        [:month, :day]
      when [:month]
        [guess_day_or_year]
      end
    end

    def next_date_groups
      next_tokens.collect do |token|
        token.date_group if token.respond_to?(:date_group)
      end.compact
    end

    def previous_date_groups
      previous_tokens.collect do |token|
        token.date_group if token.respond_to?(:date_group)
      end.compact
    end

    def token_klass_for(group)
      {
        day: Token::Day,
        month: Token::Month,
        year: Token::Year
      }.fetch(group, nil)
    end

    # for when we really just have to guess whether it's a day or a year
    def guess_day_or_year
      if looks_like_a_year? || !next_date_groups.first || value == ::Date.today.year.to_s[2..3]
        :year
      else
        :day
      end
    end
  end
end
