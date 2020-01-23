# frozen_string_literal: true

require "randrizer/types/type_builder"

module Randrizer
  module Types
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
