# frozen_string_literal: true

module Randrizer
  module Types
    class Skip
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
