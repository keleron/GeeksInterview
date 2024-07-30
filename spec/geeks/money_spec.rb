# frozen_string_literal: true

# spec/money_spec.rb
require "spec_helper"
require "geeks" # Assuming `geeks.rb` is the file containing the Geeks module and classes

RSpec.describe Geeks::Money do
  describe ".format_number" do
    it "formats numbers with thousands separators and dollar sign" do # rubocop:disable RSpec/MultipleExpectations
      expect(described_class.format_number(1000)).to eq("$1.000")
      expect(described_class.format_number(1_000_000)).to eq("$1.000.000")
      expect(described_class.format_number(123_456_789)).to eq("$123.456.789")
    end
  end
end
