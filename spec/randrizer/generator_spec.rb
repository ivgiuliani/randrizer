# frozen_string_literal: true

require "spec_helper"

require "randrizer/generator"

RSpec.describe Randrizer::Generator do
  describe "#generate" do
    let(:string_def) do
      Randrizer::Types::String.build(
        min_length: 4,
        max_length: 10,
        valid_chars: Randrizer::Types::String::CHARS_ALL_LETTERS
      )
    end
    let(:int_def) { Randrizer::Types::Int[min: 4, max: 10] }
    let(:float_def) { Randrizer::Types::Float[min: 1.1, max: 3.4] }
    let(:const_def) { Randrizer::Types::Const["yolo"] }

    context "when given a constant as root" do
      let(:input) { const_def }

      it "generates a structure matching the input" do
        expect(described_class.generate(input)).to eq("yolo")
      end
    end

    context "when given a dict as root" do
      let(:input) do
        Randrizer::Types::Dict[
          Randrizer::Types::Const["hello"] => string_def,
          Randrizer::Types::Const["world"] => int_def,
          Randrizer::Types::Const["!"] => float_def
        ]
      end

      it "generates a structure matching the input" do
        output = described_class.generate(input)

        expect(output.keys).to match_array(%w[hello world !])
        expect(output["hello"]).to match(/[a-zA-Z0-9]{4,10}/)
        expect(output["world"]).to be_an_instance_of(Integer)
        expect(output["world"]).to be >= 4
        expect(output["world"]).to be <= 10
        expect(output["!"]).to be >= 1.1
        expect(output["!"]).to be <= 3.4
      end
    end

    context "when given a string as root" do
      let(:input) { string_def }

      it "generates the correct type in output" do
        output = described_class.generate(input)

        expect(output).to be_a(String)
        expect(output).to match(/[a-zA-Z0-9]{4,10}/)
      end
    end

    context "when given an int as root" do
      let(:input) { int_def }

      it "generates the correct type in output" do
        output = described_class.generate(input)

        expect(output).to be_a(Integer)
        expect(output).to be >= 4
        expect(output).to be <= 10
      end
    end

    context "when given a float as root" do
      let(:input) { float_def }

      it "generates the correct type in output" do
        output = described_class.generate(input)

        expect(output).to be_a(Float)
        expect(output).to be >= 1.1
        expect(output).to be <= 3.4
      end
    end

    context "when given a list as root" do
      let(:input) do
        Randrizer::Types::List[
          string_def,
          int_def,
          float_def
        ]
      end

      it "generates a structure matching the input" do
        output = described_class.generate(input)

        expect(output).to be_an_instance_of(Array)
        expect(output.length).to eq(3)
        expect(output[0]).to be_a(String)
        expect(output[1]).to be_a(Integer)
        expect(output[2]).to be_a(Float)
      end
    end

    context "when given a nullable value as root" do
      let(:input) do
        Randrizer::Types::Nullable[null_prob: null_prob, inner_type: const_def]
      end
      let(:null_prob) { 0.0 }

      context "and the inner type should be null" do
        let(:null_prob) { 1.0 }

        it { expect(described_class.generate(input)).to be_nil }
      end

      context "and the inner type should not be null" do
        let(:null_prob) { 0.0 }

        it { expect(described_class.generate(input)).to eq("yolo") }
      end
    end
  end
end
