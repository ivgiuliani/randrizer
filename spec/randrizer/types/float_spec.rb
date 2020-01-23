# frozen_string_literal: true

require "spec_helper"

require "randrizer/types/float"

RSpec.describe Randrizer::Types::Float do
  subject { described_class[**params].eval }

  let(:min) { 0.1 }
  let(:max) { 3.1 }

  let(:params) do
    {
      min: min,
      max: max
    }
  end

  describe "#eval" do
    context "with a basic case" do
      it { is_expected.to be_an_instance_of(Float) }
      it { is_expected.to(be >= 0.1) && (be <= 3.1) }
    end

    context "when min and max are negative" do
      let(:min) { -10.0 }
      let(:max) { -3.0 }

      it { is_expected.to(be >= -10.0) && (be <= -3.0) }
    end

    context "when min and max are the same" do
      let(:min) { 5.0 }
      let(:max) { 5.0 }

      it { is_expected.to eq(5.0) }
    end
  end
end
