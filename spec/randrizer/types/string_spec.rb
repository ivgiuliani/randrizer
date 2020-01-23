# frozen_string_literal: true

require "spec_helper"

require "randrizer/types/string"

RSpec.describe Randrizer::Types::String do
  subject { described_class[**params].eval }

  let(:min_length) { 0 }
  let(:max_length) { 5 }
  let(:valid_chars) { described_class::DEFAULT_VALID_CHARS }

  let(:params) do
    {
      min_length: min_length,
      max_length: max_length,
      valid_chars: valid_chars
    }
  end

  describe "#eval" do
    context "with a basic case" do
      it { is_expected.to be_an_instance_of(String) }
      it { is_expected.to match(/[A-z0-9]{0,5}/) }
    end

    context "when the letter set is limited" do
      let(:valid_chars) { "abc" }
      let(:min_length) { 1000 }
      let(:max_length) { 1000 }

      it { is_expected.to match(/[abc]{1000}/) }
    end
  end
end
