# frozen_string_literal: true

require "bundler/setup"
require "randrizer"

RSpec.configure do |config|
  FIXTURE_PATH = "#{__dir__}/fixtures"

  config.example_status_persistence_file_path = ".rspec_status"
  config.disable_monkey_patching!
  config.order = :random

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  def load_fixture(*path)
    File.read(File.join(FIXTURE_PATH, *path), external_encoding: Encoding::UTF_8)
  end
end
