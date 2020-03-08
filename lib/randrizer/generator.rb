# frozen_string_literal: true

require "randrizer/types"
require "randrizer/types/type_expansion"

module Randrizer
  class Generator
    def self.generate(type)
      type_tree = Types::TypeExpansion.expand_for(type)

      type_tree.validate!
      type_tree.eval
    end
  end
end
