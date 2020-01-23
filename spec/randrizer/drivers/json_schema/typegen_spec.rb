# frozen_string_literal: true

require "spec_helper"

require "randrizer/drivers/json_schema/typegen"

RSpec.describe Randrizer::Drivers::JSONSchema::Typegen do
  let(:attrs) { {} }

  describe ".null" do
    subject(:type) { described_class.t_null(attrs) }

    it { is_expected.to be_an_instance_of(Randrizer::Types::Const) }
    it { expect(type.eval).to be_nil }
  end

  describe ".boolean" do
    subject(:type) { described_class.t_boolean(attrs) }

    it { is_expected.to be_an_instance_of(Randrizer::Types::Bool) }
  end

  describe ".string" do
    subject(:type) { described_class.t_string(attrs) }

    it { is_expected.to be_an_instance_of(Randrizer::Types::String) }

    context "when constraining the string to an enumerable" do
      let(:attrs) do
        {
          "enum" => ["value 1", "value 2"]
        }
      end

      it { is_expected.to be_an_instance_of(Randrizer::Types::OneOf) }
      it { expect(type.length).to eq(2) }
    end
  end
end
