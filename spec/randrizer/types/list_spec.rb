# frozen_string_literal: true

require "spec_helper"

require "randrizer/types"

RSpec.describe Randrizer::Types::List do
  let(:instance) { described_class[*params] }

  let(:string_def) { Randrizer::Types::String[min_length: 4, max_length: 10] }
  let(:int_def) { Randrizer::Types::Int[min: 4, max: 10] }
  let(:const_def) { Randrizer::Types::Const["yolo"] }

  let(:params) { [string_def, int_def, const_def] }

  describe "#eval" do
    subject { instance.eval }

    it { is_expected.to be_an_instance_of(Array) }
    it { expect(subject.length).to eq(3) }
    it { expect(subject[0]).to be_an_instance_of(String) }
    it { expect(subject[1]).to be_an_instance_of(Integer) }
    it { expect(subject[2]).to be_an_instance_of(String) }
    it { expect(subject[2]).to eq("yolo") }

    context "when there's an optional item" do
      let(:opt_string) do
        Randrizer::Types::Optional[
          presence_prob: presence_prob,
          inner_type: Randrizer::Types::Const["optional"]]
      end
      let(:params) { [string_def, opt_string, int_def, const_def] }

      context "and the optional item should be skipped" do
        let(:presence_prob) { 0.0 }

        it "does not include the optional item when that should be skipped" do
          expect(subject.length).to eq(3)
          expect(subject[0]).to be_an_instance_of(String)
          expect(subject[1]).to be_an_instance_of(Integer)
          expect(subject[2]).to be_an_instance_of(String)
          expect(subject[2]).to eq("yolo")
        end
      end

      context "and the optional item should be included" do
        let(:presence_prob) { 1.0 }

        it "does not include the optional item when that should be skipped" do
          expect(subject.length).to eq(4)
          expect(subject[0]).to be_an_instance_of(String)
          expect(subject[1]).to be_an_instance_of(String)
          expect(subject[1]).to eq("optional")
          expect(subject[2]).to be_an_instance_of(Integer)
          expect(subject[3]).to be_an_instance_of(String)
          expect(subject[3]).to eq("yolo")
        end
      end
    end
  end

  describe "#empty?" do
    subject { instance.empty? }

    it { is_expected.to be false }

    context "when no subkeys are defined" do
      let(:params) { [] }

      it { is_expected.to be true }
    end
  end
end
