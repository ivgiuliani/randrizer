# frozen_string_literal: true

require "randrizer/types"

module Randrizer
  module Drivers
    module JSONSchema
      class Typegen
        class << self
          MONTH_INT_TYPE =
            Types::OneOf[*((1..12).map { |i| Types::Const.build(i.to_s.rjust(2, "0")) })]
          DAY_INT_TYPE =
            Types::OneOf[*((1..31).map { |i| Types::Const.build(i.to_s.rjust(2, "0")) })]
          HOUR_INT_TYPE =
            Types::OneOf[*((0..23).map { |i| Types::Const.build(i.to_s.rjust(2, "0")) })]
          MIN_SEC_INT_TYPE =
            Types::OneOf[*((0..59).map { |i| Types::Const.build(i.to_s.rjust(2, "0")) })]

          DATE_SEQUENCE = [
            Types::Int.build(min: 1970, max: 2200),
            Types::Const["-"],
            MONTH_INT_TYPE,
            Types::Const["-"],
            DAY_INT_TYPE
          ].freeze

          TIMEZONE_SEQUENCE = Types::OneOf.build(
            Types::Const["Z"],
            Types::StringSequence.build(
              Types::OneOf.build(Types::Const["+"], Types::Const["-"]),
              HOUR_INT_TYPE,
              Types::Const[":"],
              MIN_SEC_INT_TYPE
            )
          )

          TIME_SEQUENCE = [
            HOUR_INT_TYPE,
            Types::Const[":"],
            MIN_SEC_INT_TYPE,
            Types::Const[":"],
            MIN_SEC_INT_TYPE,
            Types::Optional.build(inner_type: TIMEZONE_SEQUENCE)
          ].freeze

          EMAIL_SEQUENCE = [
            Types::String.build(valid_chars: Types::String::CHARS_ALL_LETTERS + "._+"),
            Types::Const["@"],
            Types::String.build(valid_chars: Types::String::CHARS_ALL_LETTERS + "._")
          ].freeze

          def t_null(_attrs)
            # `Types::Nullable` would require an inner type, as this will never change
            # we can just return a constant null value.
            Types::Const[nil]
          end

          def t_boolean(_attrs)
            Types::Bool[]
          end

          def t_number(attrs)
            # TODO: support multipleOf

            restrictions = {}
            restrictions[:min] = attrs.fetch("minimum", -999_999_999)
            restrictions[:max] = attrs.fetch("maximum", 999_999_999)

            restrictions[:min] += 1 if attrs.fetch("exclusiveMinimum", false)
            restrictions[:max] -= 1 if attrs.fetch("exclusiveMaximum", false)

            Types::Int.build(**restrictions)
          end

          def t_integer(attrs)
            t_number(attrs)
          end

          def t_string_with_format(_attrs, format)
            # https://json-schema.org/understanding-json-schema/reference/string.html#built-in-formats

            case format
            when "date"
              Types::StringSequence.build(*DATE_SEQUENCE)
            when "time"
              Types::StringSequence.build(*TIME_SEQUENCE)
            when "date-time"
              Types::StringSequence.build(
                *DATE_SEQUENCE,
                Types::Const["T"],
                *TIME_SEQUENCE
              )
            when "email"
              Types::StringSequence.build(*EMAIL_SEQUENCE)
            else
              raise "Format not supported: #{format}"
            end
          end

          def t_string(attrs)
            # TODO: support String patterns format specs

            if attrs.include?("enum")
              return Types::OneOf[
                *attrs["enum"].map { |e| Types::Const[e] }
              ]
            end

            if attrs.include?("format")
              return t_string_with_format(attrs, attrs["format"])
            end

            props = {}
            props[:min_length] = attrs["minLength"].to_i if attrs.include?("minLength")
            props[:max_length] = attrs["maxLength"].to_i if attrs.include?("maxLength")

            Types::String.build(**props)
          end
        end
      end
    end
  end
end
