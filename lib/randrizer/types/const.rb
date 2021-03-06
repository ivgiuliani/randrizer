# frozen_string_literal: true

require "randrizer/types/base_type"

module Randrizer
  module Types
    # A constant type. Any type passed as argument will be returned as given.
    class Const
      include BaseType

      class << self
        def build(params)
          new(params)
        end

        alias [] build
      end

      def initialize(params)
        @params = params
      end

      def validate!; end

      def eval
        @params
      end
    end
  end
end
