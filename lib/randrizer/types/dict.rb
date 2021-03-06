# frozen_string_literal: true

require "randrizer/types/skip"
require "randrizer/types/base_type"

module Randrizer
  module Types
    class Dict
      include BaseType

      class << self
        # @param [Hash{BaseType => BaseType}] keys_def
        def build(keys_def)
          new(keys_def)
        end

        alias [] build
      end

      def initialize(keys_def)
        @keys_def = keys_def
      end

      def validate!; end

      def eval
        @keys_def.each_with_object({}) do |(key_type, value_type), hash|
          key = key_type.eval
          value = value_type.eval

          next if key == SKIP || value == SKIP

          hash[key] = value
        end
      end

      def empty?
        @keys_def.empty?
      end
    end
  end
end
