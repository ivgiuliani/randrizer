# frozen_string_literal: true

require "randrizer/types/type_builder"

module Randrizer
  module Types
    # A boolean type. Can be either `true` or `false`.
    class Bool
      include TypeBuilder

      PRESENCE_MAYBE = 0.5

      def initialize(true_prob: PRESENCE_MAYBE)
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
