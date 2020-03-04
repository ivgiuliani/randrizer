# frozen_string_literal: true

require "spec_helper"

require "randrizer/types"

RSpec.describe Randrizer::Types::StringSequence do
  let(:instance) { described_class[params] }

  let(:string_def) { Randrizer::Types::String[min_length: 4, max_length: 10] }
  let(:int_def) { Randrizer::Types::Int[min: 4, max: 10] }
  let(:const_def) { Randrizer::Types::Const["yolo"] }

  let(:params) { [string_def, int_def, const_def] }

  it {
    expect(described_class.build(params)).to be_a_kind_of(Randrizer::Types::BaseType)
  }

  describe "#eval" do
    subject { instance.eval }

    it { is_expected.to be_an_instance_of(String) }

    # The minimum length is 4 chars for the string, 1 digit for the int and 4 letters for
    # the const
    it { expect(subject.length).to be >= 9 }

    # The maximum length is 10 chars for the string, 2 digits for the int and 4 letters
    # for the const
    it { expect(subject.length).to be <= 16 }

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
          is_expected.to be_an_instance_of(String)
          expect(subject).not_to include("optional")
        end
      end

      context "and the optional item should be included" do
        let(:presence_prob) { 1.0 }

        it "does not include the optional item when that should be skipped" do
          is_expected.to be_an_instance_of(String)
          expect(subject).to include("optional")
        end
      end
    end
  end

  describe "#empty?" do
    subject { instance.empty? }

    it { is_expected.to be false }

    context "when no sequence is defined" do
      let(:params) { [] }

      it { is_expected.to be true }
    end
  end
end
