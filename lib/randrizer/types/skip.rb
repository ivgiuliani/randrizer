# frozen_string_literal: true

require "randrizer/types/base_type"

module Randrizer
  module Types
    class Skip < BaseType
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
