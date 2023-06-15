# frozen_string_literal: true

require "date"

require_relative "strftimer_gem/version"
require_relative "translator"
require_relative "escape_translator"
require_relative "iso_translator"
require_relative "time_translator"
require_relative "date_translator"

module StrftimerGem
  class Error < StandardError; end
end
