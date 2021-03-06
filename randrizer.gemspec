# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "randrizer/version"

Gem::Specification.new do |spec|
  spec.name          = "randrizer"
  spec.homepage      = "https://github.com/ivgiuliani/randrizer"
  spec.version       = Randrizer::VERSION
  spec.authors       = ["Ivan Giuliani"]
  spec.email         = ["giuliani.v@gmail.com"]

  spec.summary       = "Generate random data for testing"
  spec.description   = "Random data generator with type composition"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.required_ruby_version = ">= 2.5"

  spec.add_dependency "ruby2_keywords", "~> 0.0.2"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "pry-byebug", "~> 3.9.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "redcarpet", "~> 3.5.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rspec_junit_formatter", "0.4.1"
  spec.add_development_dependency "rubocop", "~> 0.93.1"
  spec.add_development_dependency "rubocop-rspec", "~> 1.44.1"
end
