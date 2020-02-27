# frozen_string_literal: true

require "ruby2_keywords"
require "randrizer/types/type_validation_error"

module Randrizer
  module Types
    class BaseType
      def initialize(*args, **kwargs, &block); end

      # @raise [TypeValidationError] if the arguments given to the type are not valid
      def validate!
        raise NotImplementedError
      end

      class << self
        # Required for compatibility with Ruby <= 2.6. See
        # https://www.ruby-lang.org/en/news/2019/12/12/separation-of-positional-and-keyword-arguments-in-ruby-3-0/
        ruby2_keywords def build(*args, &block)
          new(*args, &block)
        end

        alias [] build
      end
    end
  end
end
