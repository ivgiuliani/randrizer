# frozen_string_literal: true

require "spec_helper"

require "randrizer/types"

RSpec.describe Randrizer::Types::OneOf do
  let(:instance) { described_class[params] }

  let(:const_def1) { Randrizer::Types::Const["hello"] }
  let(:const_def2) { Randrizer::Types::Const["yolo"] }
  let(:const_def3) { Randrizer::Types::Const["world"] }

  let(:params) { [const_def1, const_def2, const_def3] }

  describe "#eval" do
    subject { described_class[params].eval }

    it "returns one of the input items" do
      expect(subject).to be_an_instance_of(String)
      expect(subject).to satisfy { |x| %w[hello world yolo].include?(x) }
    end
  end

  describe "#length" do
    subject { instance.length }

    it "returns the number of items in the list definition" do
      expect(subject).to eq(3)
    end
  end
end
