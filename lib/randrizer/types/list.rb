# frozen_string_literal: true

require "randrizer/types/skip"
require "randrizer/types/base_type"

module Randrizer
  module Types
    class List
      include BaseType

      class << self
        def build(*args)
          new(*args)
        end

        alias [] build
      end

      def initialize(*args)
        @list_def = args
      end

      def validate!
        !@list_def.nil?
      end

      def eval
        @list_def.map { |item| TypeExpansion.expand_for(item).eval }.reject do |evaluated|
          evaluated == SKIP
        end
      end

      def empty?
        @list_def.empty?
      end
    end
  end
end
