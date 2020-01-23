# frozen_string_literal: true

require "spec_helper"

require "randrizer/types/int"

RSpec.describe Randrizer::Types::Int do
  subject { described_class[**params].eval }

  let(:min) { 0 }
  let(:max) { 3 }

  let(:params) do
    {
      min: min,
      max: max
    }
  end

  describe "#eval" do
    context "with a basic case" do
      it { is_expected.to be_an_instance_of(Integer) }
      it { is_expected.to(be >= 0) && (be <= 3) }
    end

    context "when min and max are negative" do
      let(:min) { -10 }
      let(:max) { -3 }

      it { is_expected.to(be >= -10) && (be <= -3) }
    end

    context "when min and max are the same" do
      let(:min) { 5 }
      let(:max) { 5 }

      it { is_expected.to eq(5) }
    end
  end
end
