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
        def build(*sequence_def)
          new(*sequence_def)
        end

        alias [] build
      end

      def initialize(*sequence_def)
        @sequence_def = sequence_def
      end

      def validate!
        disallowed = expanded_sequence
                     .reject { |item| ALLOWED_TYPES.include?(item.class) }

        raise ValidationError("types not allowed in a string sequence: #{disallowed}")
      end

      def eval
        expanded_sequence
          .map(&:eval)
          .reject { |evaluated| evaluated == SKIP }
          .compact
          .join
      end

      def empty?
        expanded_sequence.empty?
      end

      private

      def expanded_sequence
        @expanded_sequence ||= @sequence_def.map { |t| TypeExpansion.expand_for(t) }
      end
    end
  end
end
