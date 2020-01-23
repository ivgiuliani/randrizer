# frozen_string_literal: true

require "spec_helper"

require "randrizer/types"

RSpec.describe Randrizer::Types::Skip do
  describe "#==" do
    it "assumes two different objects are the same" do
      expect(described_class.new).to eq(described_class.new)
    end
  end
end
