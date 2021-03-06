# frozen_string_literal: true

require "randrizer/types/base_type"

module Randrizer
  module Types
    # A primitive integer type. The evaluation will generate a random number between
    # the given `min` and `max`.
    class Int
      include BaseType

      # Default minimum generable number
      DEFAULT_MIN = 0

      # Default maximum generable number
      DEFAULT_MAX = 9_999_999_999

      class << self
        def build(min: DEFAULT_MIN, max: DEFAULT_MAX)
          new(min: min, max: max)
        end

        alias [] build
      end

      def initialize(min:, max:)
        @min = min
        @max = max
      end

      def validate!
        return if @max >= @min

        raise ValidationError("invalid min/max configuration")
      end

      def eval
        return @min if @min == @max

        rand(@min..@max)
      end
    end
  end
end
