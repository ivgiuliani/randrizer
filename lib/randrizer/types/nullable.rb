# frozen_string_literal: true

require "randrizer/types/base_type"
require "randrizer/types/type_expansion"

module Randrizer
  module Types
    class Nullable
      include BaseType

      class << self
        def build(null_prob:, inner_type:)
          new(null_prob: null_prob, inner_type: inner_type)
        end

        alias [] build
      end

      def initialize(null_prob:, inner_type:)
        @null_prob = null_prob
        @inner_type = inner_type
      end

      def validate!
        raise ValidationError("null_prob must be < 1.0") if @null_prob > 1.0
        raise ValidationError("null_prob must be > 0.0") if @null_prob < 0.0
      end

      def eval
        return nil if rand > (1.0 - @null_prob)

        TypeExpansion.expand_for(@inner_type).eval
      end
    end
  end
end
