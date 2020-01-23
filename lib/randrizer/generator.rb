# frozen_string_literal: true

require "randrizer/types"

module Randrizer
  class Generator
    def self.generate(type)
      type.validate!
      type.eval
    end
  end
end
