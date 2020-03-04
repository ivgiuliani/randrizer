# frozen_string_literal: true

require "randrizer/types/base_type"

module Randrizer
  module Types
    class String
      include BaseType

      CHARS_NUMBERS = "0123456789"
      CHARS_SYMBOLS = " !\"£$%^&()=-*/[]#\\~"
      CHARS_LOWERCASE_LETTERS = "abcdfeghijklmnopqrstuvwxyz"
      CHARS_UPPERCASE_LETTERS = CHARS_LOWERCASE_LETTERS.upcase
      CHARS_ALL_LETTERS = CHARS_LOWERCASE_LETTERS + CHARS_UPPERCASE_LETTERS

      DEFAULT_VALID_CHARS =
        CHARS_NUMBERS +
        CHARS_ALL_LETTERS +
        CHARS_SYMBOLS

      DEFAULT_MIN_LENGTH = 0
      DEFAULT_MAX_LENGTH = 99

      class << self
        def build(min_length: DEFAULT_MIN_LENGTH,
                  max_length: DEFAULT_MAX_LENGTH,
                  valid_chars: DEFAULT_VALID_CHARS)
          new(min_length: min_length,
              max_length: max_length,
              valid_chars: valid_chars)
        end

        alias [] build
      end

      def initialize(min_length:, max_length:, valid_chars:)
        @min_length = min_length
        @max_length = max_length
        @valid_chars = valid_chars
      end

      def validate!
        return if @max_length >= @min_length

        raise ValidationError("invalid length configuration")
      end

      def eval
        chars_split = @valid_chars.split("")
        string_length = rand(@min_length..@max_length)
        string_length.times.map { chars_split.sample }.join
      end
    end
  end
end
