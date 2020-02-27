# frozen_string_literal: true

require "randrizer/types/type_validation_error"

module Randrizer
  module Types
    class BaseType
      # @raise [TypeValidationError] if the arguments given to the type are not valid
      def validate!
        raise NotImplementedError
      end

      class << self
        def build(*args, **kwargs)
          new(*args, **kwargs)
        end

        alias [] build
      end
    end
  end
end
