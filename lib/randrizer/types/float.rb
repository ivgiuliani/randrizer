# frozen_string_literal: true

require "randrizer/types/base_type"

module Randrizer
  module Types
    class Float < BaseType
      DEFAULT_MIN = 0.0
      DEFAULT_MAX = 9_999_999_999.0

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

        rand * (@max - @min) + @min
      end
    end
  end
end
