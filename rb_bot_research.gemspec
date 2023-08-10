# frozen_string_literal: true

require_relative "lib/rb_bot_research/version"

Gem::Specification.new do |spec|
  spec.name = "rb_bot_research"
  spec.version = RbBotResearch::VERSION
  spec.authors = ["Al White"]
  spec.email = ["al@launchscout.com"]

  spec.summary = "A composed message discord bot."
  spec.description = "This is a research project for composed messages in a discord bot."
  spec.homepage = "https://team.launchscout.com"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/alcwhite/rb_bot_research"

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

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "discordrb", "~> 3.4.0"
  spec.add_dependency "dotenv", "~> 2.8"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
