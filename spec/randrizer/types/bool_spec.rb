# frozen_string_literal: true

require "spec_helper"

require "randrizer/types"

RSpec.describe Randrizer::Types::Bool do
  subject { described_class.build(**params).eval }

  let(:true_prob) { 0.0 }

  let(:params) do
    {
      true_prob: true_prob
    }
  end

  it {
    expect(described_class.build(**params)).to be_a_kind_of(Randrizer::Types::BaseType)
  }

  describe "#eval" do
    context "when it should always return true" do
      let(:true_prob) { 1.0 }

      it { is_expected.to be true }
    end

    context "when it should always return false" do
      let(:true_prob) { 0.0 }

      it { is_expected.to be false }
    end
  end
end
