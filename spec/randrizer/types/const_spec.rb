# frozen_string_literal: true

require "spec_helper"

require "randrizer/types/const"

RSpec.describe Randrizer::Types::Const do
  subject { described_class[params].eval }

  let(:params) { 1 }

  describe "#eval" do
    it { is_expected.to eq(params) }
  end
end
