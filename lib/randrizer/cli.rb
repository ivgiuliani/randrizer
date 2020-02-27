# frozen_string_literal: true

require "randrizer/version"
require "randrizer"
require "randrizer/drivers/json_schema"

module Randrizer
  class Cli
    def self.run
      return help if ARGV.empty?

      fname = ARGV[0]
      unless File.exist?(fname)
        raise ArgumentError, "#{fname} does not exist or cannot be accessed"
      end

      input_json = File.read(fname)
      type_tree = Drivers::JSONSchema::Driver.for(content: input_json).type_tree
      output = type_tree.eval
      puts JSON.pretty_generate(output)
    end

    def self.help
      STDOUT.write("Randrizer #{Randrizer::VERSION}\n")
    end
  end
end
