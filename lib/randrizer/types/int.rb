# frozen_string_literal: true

require "randrizer/types/type_builder"

module Randrizer
  module Types
    class Int
      include TypeBuilder

      DEFAULT_MIN = 0
      DEFAULT_MAX = 9_999_999_999

      def initialize(min: DEFAULT_MIN, max: DEFAULT_MAX)
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
