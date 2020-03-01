# frozen_string_literal: true

require "json"

require "randrizer/drivers/json_schema/typegen"

module Randrizer
  module Drivers
    module JSONSchema
      class Driver
        # JSON Schemas are much more complex than one would initially imagine. This is a
        # very simple driver for basic schemas, but not all the attributes and properties
        # of types are respected.
        # TODO: support for list and dict datatypes

        attr_reader :path

        def self.for(content:)
          parsed_content = JSON.parse(content)
          new(parsed_content)
        end

        def initialize(parsed_schema)
          @json = parsed_schema
        end

        def type_tree
          dict = {}

          required_keys = json.fetch("required", [])
          json.fetch("properties", []).map do |key, attrs|
            key_type = Types::Const[key]
            root_type = attrs["type"]
            value_type = gen_value_type(root_type, attrs)

            unless required_keys.include?(key)
              key_type = Types::Optional[inner_type: key_type]
            end

            dict[key_type] = value_type
          end

          Types::Dict.build(**dict)
        end

        private

        attr_reader :json

        def gen_value_type(type, attrs)
          case type
          when "integer"
            Typegen.t_integer(attrs)
          when "number"
            Typegen.t_number(attrs)
          when "boolean"
            Typegen.t_boolean(attrs)
          when "string"
            Typegen.t_string(attrs)
          when "null"
            Typegen.t_null(attrs)
          when Array
            Types::OneOf.build(type.map { |sub_t| gen_value_type(sub_t, attrs) })
          else
            raise "Unsupported type: #{type}"
          end
        end
      end
    end
  end
end
