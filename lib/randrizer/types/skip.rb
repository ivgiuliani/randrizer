# frozen_string_literal: true

require "randrizer/types/base_type"

module Randrizer
  module Types
    # Special type to be skipped when encountered by iterable types.
    class Skip
      include BaseType

      class << self
        def build
          new
        end

        alias [] build
      end

      def ==(other)
        other.class == Skip
      end

      def eval
        self
      end
    end

    SKIP = Skip.new
  end
end
