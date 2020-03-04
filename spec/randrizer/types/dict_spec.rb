# frozen_string_literal: true

require "spec_helper"

require "randrizer/types"

RSpec.describe Randrizer::Types::Dict do
  let(:instance) { described_class.build(params) }

  let(:string_def) { Randrizer::Types::String[min_length: 4, max_length: 10] }
  let(:int_def) { Randrizer::Types::Int[min: 4, max: 10] }

  let(:params) do
    {
      Randrizer::Types::Const["hello"] => string_def,
      Randrizer::Types::Const["world"] => int_def
    }
  end

  it {
    expect(described_class.build(params)).to be_a_kind_of(Randrizer::Types::BaseType)
  }

  describe "#eval" do
    subject { instance.eval }

    context "with a basic case" do
      it { is_expected.to be_an_instance_of(Hash) }
      it { expect(subject.keys).to match_array(%w[hello world]) }
      it { expect(subject["hello"]).to match(/[A-z0-9]+/) }
      it { expect(subject["world"]).to be >= 4 }
    end

    context "when the input contains nested values" do
      let(:params) do
        {
          Randrizer::Types::Const["hello"] => string_def,
          Randrizer::Types::Const["world"] => int_def,
          Randrizer::Types::Const["nested"] => described_class[
            Randrizer::Types::Const["nested1"] => string_def,
            Randrizer::Types::Const["nested2"] => int_def
          ]
        }
      end

      it { is_expected.to be_an_instance_of(Hash) }
      it { expect(subject.keys).to match_array(%w[hello world nested]) }
      it { expect(subject["hello"]).to match(/[A-z0-9]+/) }
      it { expect(subject["world"]).to be >= 4 }
      it { expect(subject["nested"]).to be_an_instance_of(Hash) }
      it { expect(subject["nested"].keys).to match_array(%w[nested1 nested2]) }
    end

    context "when there's an optional item" do
      let(:opt_string) do
        Randrizer::Types::Optional[
          presence_prob: presence_prob,
          inner_type: Randrizer::Types::Const["optional"]]
      end
      let(:params) do
        {
          Randrizer::Types::Const["hello"] => string_def,
          opt_string => Randrizer::Types::Const["yolo"],
          Randrizer::Types::Const["world"] => int_def
        }
      end

      context "and the optional item should be skipped" do
        let(:presence_prob) { 0.0 }

        it "does not include the optional item when that should be skipped" do
          expect(subject.keys).to match_array(%w[hello world])
          expect(subject["hello"]).to be_an_instance_of(String)
          expect(subject["world"]).to be_an_instance_of(Integer)
        end
      end

      context "and the optional item should be included" do
        let(:presence_prob) { 1.0 }

        it "does not include the optional item when that should be skipped" do
          expect(subject.keys).to match_array(%w[hello optional world])
          expect(subject["hello"]).to be_an_instance_of(String)
          expect(subject["optional"]).to eq("yolo")
          expect(subject["world"]).to be_an_instance_of(Integer)
        end
      end
    end
  end

  describe "#empty?" do
    subject { instance.empty? }

    it { is_expected.to be false }

    context "when no subkeys are defined" do
      let(:params) { {} }

      it { is_expected.to be true }
    end
  end
end
