# frozen_string_literal: true

require "randrizer/types/type_builder"

module Randrizer
  module Types
    # A constant type. Any type passed as argument will be returned as given.
    class Const
      include TypeBuilder

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
