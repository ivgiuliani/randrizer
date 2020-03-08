# frozen_string_literal: true

require "spec_helper"

require "randrizer/types/type_expansion"

RSpec.describe Randrizer::Types::TypeExpansion do
  describe "#expand_for" do
    let(:short_string) do
      Randrizer::Types::String.build(
        max_length: 3,
        valid_chars: Randrizer::Types::String::CHARS_LOWERCASE_LETTERS
      )
    end

    context "with constant values" do
      let(:const) { 123 }

      context "when the constant is a string" do
        let(:const) { "a string" }

        it do
          expanded = described_class.expand_for(const)

          expect(expanded).to be_an_instance_of(Randrizer::Types::Const)
          expect(expanded.eval).to eq(const)
        end
      end

      context "when the constant is an integer" do
        let(:const) { 1234 }

        it do
          expanded = described_class.expand_for(const)

          expect(expanded).to be_an_instance_of(Randrizer::Types::Const)
          expect(expanded.eval).to eq(const)
        end
      end

      context "when the constant is a float" do
        let(:const) { 1234.56 }

        it do
          expanded = described_class.expand_for(const)

          expect(expanded).to be_an_instance_of(Randrizer::Types::Const)
          expect(expanded.eval).to eq(const)
        end
      end

      context "when the constant is nil" do
        let(:const) { nil }

        it do
          expanded = described_class.expand_for(const)

          expect(expanded).to be_an_instance_of(Randrizer::Types::Const)
          expect(expanded.eval).to be_nil
        end
      end
    end

    context "with a list" do
      let(:list) { [1, 2, 3] }

      it do
        expanded = described_class.expand_for(list)

        expect(expanded).to be_an_instance_of(Randrizer::Types::List)
        expect(expanded).not_to be_empty
        expect(expanded.eval).to eq([1, 2, 3])
      end

      context "when the list includes other randrizer types" do
        let(:list) do
          [
            Randrizer::Types::Const["yolo"],
            short_string
          ]
        end

        it do
          expanded = described_class.expand_for(list)

          expect(expanded).to be_an_instance_of(Randrizer::Types::List)
          expect(expanded).not_to be_empty
          expect(expanded.eval).to match(["yolo", /[a-z]{,3}/])
        end
      end
    end

    context "with a hash" do
      let(:hash) { { "yolo" => 1234 } }

      it do
        expanded = described_class.expand_for(hash)

        expect(expanded).to be_an_instance_of(Randrizer::Types::Dict)
        expect(expanded.eval).to eq(hash)
      end

      context "when the hash includes a randrizer type" do
        let(:hash) { { "yolo" => short_string } }

        it do
          expanded = described_class.expand_for(hash)

          expect(expanded).to be_an_instance_of(Randrizer::Types::Dict)
          expect(expanded.eval).to match({ "yolo" => /[a-z]{,3}/ })
        end
      end

      context "when the hash includes nested hashes" do
        let(:hash) do
          {
            "yolo" => {
              "hello" => "world"
            }
          }
        end

        it do
          expanded = described_class.expand_for(hash)

          expect(expanded).to be_an_instance_of(Randrizer::Types::Dict)
          expect(expanded.eval).to match({ "yolo" => { "hello" => "world" } })
        end
      end
    end
  end
end
