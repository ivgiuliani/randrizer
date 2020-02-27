# frozen_string_literal: true

require "spec_helper"

require "randrizer/types"

RSpec.describe Randrizer::Types::Nullable do
  subject { described_class.build(**params).eval }

  let(:null_prob) { 0.0 }
  let(:const_def) { Randrizer::Types::Const["yolo"] }

  let(:params) do
    {
      null_prob: null_prob,
      inner_type: const_def
    }
  end

  describe "#eval" do
    context "when the inner type can't be null" do
      let(:null_prob) { 0.0 }

      it { is_expected.to eq("yolo") }
    end

    context "when the inner type should always be null" do
      let(:null_prob) { 1.0 }

      it { is_expected.to be_nil }
    end
  end
end
