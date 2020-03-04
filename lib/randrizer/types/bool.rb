# frozen_string_literal: true

require "randrizer/types/base_type"

module Randrizer
  module Types
    # A boolean type. Can be either `true` or `false`.
    class Bool
      include BaseType

      PRESENCE_MAYBE = 0.5

      class << self
        def build(true_prob: PRESENCE_MAYBE)
          new(true_prob: true_prob)
        end

        alias [] build
      end

      def initialize(true_prob:)
        @true_prob = true_prob
      end

      def validate!
        raise ValidationError("true_prob must be < 1.0") if @true_prob > 1.0
        raise ValidationError("true_prob must be > 0.0") if @true_prob < 0.0
      end

      def eval
        rand > (1.0 - @true_prob)
      end
    end
  end
end
