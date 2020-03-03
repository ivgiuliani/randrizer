# frozen_string_literal: true

require "randrizer/types/base_type"

module Randrizer
  module Types
    class StringSequence
      include BaseType

      ALLOWED_TYPES = [
        Types::Int,
        Types::String,
        Types::Const,
        Types::Nullable,
        Types::Optional,
        Types::OneOf
      ].freeze

      class << self
        def build(sequence_def)
          new(sequence_def)
        end

        alias [] build
      end

      def initialize(sequence_def)
        @sequence_def = sequence_def
      end

      def validate!
        disallowed = @sequence_def.reject { |item| ALLOWED_TYPES.include?(item.class) }

        raise ValidationError("types not allowed in a string sequence: #{disallowed}")
      end

      def eval
        @sequence_def.map(&:eval).reject { |evaluated| evaluated == SKIP }.compact.join
      end

      def empty?
        @sequence_def.empty?
      end
    end
  end
end
