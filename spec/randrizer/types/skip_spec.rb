# frozen_string_literal: true

require "spec_helper"

require "randrizer/types"

RSpec.describe Randrizer::Types::Skip do
  it { expect(described_class.build).to be_a_kind_of(Randrizer::Types::BaseType) }

  describe "#==" do
    it "assumes two different objects are the same" do
      expect(described_class.new).to eq(described_class.new)
    end
  end
end
