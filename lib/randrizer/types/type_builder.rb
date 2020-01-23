# frozen_string_literal: true

module Randrizer
  module Types
    module TypeBuilder
      class ValidationError < StandardError; end

      def self.included(base)
        base.extend(ClassMethods)
      end

      def validate!
        raise NotImplementedError
      end

      module ClassMethods
        def build(*args, **params)
          new(*args, **params)
        end

        alias [] build
      end
    end
  end
end
