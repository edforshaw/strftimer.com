# frozen_string_literal: true

require_relative "lib/strftimer_gem/version"

Gem::Specification.new do |spec|
  spec.name = "strftimer_gem"
  spec.version = StrftimerGem::VERSION
  spec.authors = ["gatorjuice"]
  spec.email = ["gatorjuice@gmail.com"]

  spec.summary = "Gem implementation of strftimer.com"
  spec.description = "Provides the functionality of strftimer.com via a Gem"
  spec.homepage = "https://github.com/gatorjuice/strftimer_gem"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) || f.start_with?(*%w[bin/ test/ spec/ features/ .git .circleci appveyor])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
