# frozen_string_literal: true

require "spec_helper"

require "randrizer/types/const"
require "randrizer/types/string"

RSpec.describe Randrizer::Types::Const do
  subject { described_class[params].eval }

  let(:params) { 1 }

  describe "#eval" do
    it { is_expected.to eq(params) }

    context "when it includes another Randrizer type" do
      let(:params) do
        Randrizer::Types::String[min_length: 3, max_length: 3]
      end

      it "will not be evaluated" do
        is_expected.to be_an_instance_of(Randrizer::Types::String)
      end
    end
  end
end
