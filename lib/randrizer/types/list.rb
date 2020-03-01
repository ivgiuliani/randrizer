# frozen_string_literal: true

require "randrizer/types/skip"
require "randrizer/types/base_type"

module Randrizer
  module Types
    class List < BaseType
      def initialize(*args)
        @list_def = args
      end

      def validate!
        !@list_def.nil?
      end

      def eval
        @list_def.map(&:eval).reject { |evaluated| evaluated == SKIP }
      end

      def empty?
        @list_def.empty?
      end
    end
  end
end
