# frozen_string_literal: true

# spec/runner_spec.rb
require "spec_helper"
require "httparty"
require "geeks" # Assuming `geeks.rb` is the file containing the Geeks module and classes

RSpec.describe Geeks::Runner do
  let(:argv) do
    ["--client_dni", "76329692-K", "--debtor_dni", "77360390-1", "--document_amount", "1000000", "--folio", "75",
     "--expiration_date", "2024-08-29", "--api_key", "your_api_key_here"]
  end
  let(:runner) { described_class.new(argv) }
  let(:parsed_response) { { "document_rate" => 1.09, "commission" => 0, "advance_percent" => 99.0 } }
  let(:httparty_response) { instance_double(HTTParty::Response, parsed_response: parsed_response) }

  before do
    allow(HTTParty).to receive(:get).and_return(httparty_response)
    allow(Date).to receive(:today).and_return(Date.new(2024, 7, 30))
  end

  describe "#initialize" do
    it "initializes with given arguments" do
      expect(runner.instance_variable_get(:@query)).to be_a(Hash)
    end
  end

  describe "#run" do
    it "calls HTTParty with correct URL and query parameters" do
      result = runner.run
      expect(result).to eq({ financing_cost: 11_150, amount_to_recieve: 978_849, excess: 10_000 })
    end
  end
end
