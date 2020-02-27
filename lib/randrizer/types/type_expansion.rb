# frozen_string_literal: true

require "randrizer/types"

module Randrizer
  module Types
    class TypeExpansion
      # Combines ruby's native types with randrizer types.
      #
      # @param [Object] type
      #   returns a version of the type that can be used as a base for a type tree
      # @return [Randrizer::Types::BaseType] a type-tree ready type
      def self.expand_for(type)
        case type
        when BaseType
          # If it's one of our own types just return it as it is
          type
        when ::Array
          Types::List.build(
            *type.map { |entry| expand_for(entry) }
          )
        when ::Hash
          hash_def = type.each_with_object({}) do |(k, v), acc|
            key_type = expand_for(k)
            value_type = expand_for(v)
            acc[key_type] = value_type
          end

          Types::Dict.build(hash_def)
        when ::Integer, ::Float,
             ::String, ::Symbol
          Types::Const.build(type)
        when nil
          Types::Const.build(nil)
        else
          raise "Unsupported type: #{type.class} (#{type})"
        end
      end
    end
  end
end
