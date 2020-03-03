# frozen_string_literal: true

require "ruby2_keywords"
require "randrizer/types/type_validation_error"

module Randrizer
  module Types
    module BaseType
      # @raise [TypeValidationError] if the arguments given to the type are not valid
      def validate!
        raise NotImplementedError
      end
    end
  end
end
