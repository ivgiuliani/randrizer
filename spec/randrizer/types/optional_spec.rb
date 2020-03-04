# frozen_string_literal: true

require "spec_helper"

require "randrizer/types"

RSpec.describe Randrizer::Types::Optional do
  subject { described_class.build(**params).eval }

  let(:presence_prob) { 0.0 }
  let(:const_def) { Randrizer::Types::Const["yolo"] }

  let(:params) do
    {
      presence_prob: presence_prob,
      inner_type: const_def
    }
  end

  it {
    expect(described_class.build(**params)).to be_a_kind_of(Randrizer::Types::BaseType)
  }

  describe "#eval" do
    context "when the inner type should be skipped" do
      let(:presence_prob) { 0.0 }

      it { is_expected.to eq(Randrizer::Types::SKIP) }
    end

    context "when the inner type should always be present" do
      let(:presence_prob) { 1.0 }

      it { is_expected.to eq("yolo") }
    end
  end
end
