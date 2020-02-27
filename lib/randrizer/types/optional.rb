# frozen_string_literal: true

require "randrizer/types/skip"
require "randrizer/types/base_type"
require "randrizer/types/type_expansion"

module Randrizer
  module Types
    class Optional
      include BaseType

      PRESENCE_MAYBE = 0.5

      class << self
        def build(inner_type:, presence_prob: PRESENCE_MAYBE)
          new(inner_type: inner_type, presence_prob: presence_prob)
        end

        alias [] build
      end

      def initialize(inner_type:, presence_prob:)
        @inner_type = inner_type
        @presence_prob = presence_prob
      end

      def validate!
        raise ValidationError("presence_prob must be < 1.0") if @presence_prob > 1.0
        raise ValidationError("presence_prob must be > 0.0") if @presence_prob < 0.0
      end

      def eval
        return SKIP if rand > @presence_prob

        TypeExpansion.expand_for(@inner_type).eval
      end
    end
  end
end
