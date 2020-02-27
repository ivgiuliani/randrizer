# frozen_string_literal: true

require "randrizer/types/base_type"

module Randrizer
  module Types
    class OneOf < BaseType
      def initialize(list_def)
        @list_def = list_def
      end

      def validate!
        !@list_def.nil?
      end

      def eval
        @list_def.sample.eval
      end

      def length
        @list_def.length
      end

      alias count length
    end
  end
end
