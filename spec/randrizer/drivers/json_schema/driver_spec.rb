# frozen_string_literal: true

require "spec_helper"

require "randrizer/drivers/json_schema/driver"

require "json"

RSpec.describe Randrizer::Drivers::JSONSchema::Driver do
  let(:obj) { {} }
  let(:json) { JSON.generate(obj) }
  let(:instance) { described_class.for(content: json) }

  context "when given an empty schema" do
    it "generates an empty type tree" do
      expect(instance.type_tree).to be_empty
    end
  end
end
