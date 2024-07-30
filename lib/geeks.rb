# frozen_string_literal: true

require_relative "geeks/version"
require_relative "options"
require_relative "money"
require "httparty"
require "date"
require "debug"

module Geeks
  class Error < StandardError; end
end

module Geeks
  Quote = Struct.new(:document_rate, :commission, :advance_percent)
end

module Geeks
  class Runner # rubocop:disable Style/Documentation
    attr_reader :financing_cost, :amount_to_recieve, :excess

    def initialize(argv)
      @query = Options.new(argv).options
      @url = "https://chita.cl/api/v1/pricing/simple_quote"
    end

    def run # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
      response = HTTParty.get(@url, query: @query, headers: { "X-Api-Key" => @query[:api_key] })
      quote = Quote.new(**response.parsed_response)

      delta = @query[:expiration_date] - Date.today + 1
      ammount_per_advance_percent = @query[:document_amount] * quote.advance_percent / 100.0
      @financing_cost = ammount_per_advance_percent * (quote.document_rate / 100 * delta / 30.0)
      @amount_to_recieve = ammount_per_advance_percent - (@financing_cost + quote.commission)
      @excess = @query[:document_amount] - ammount_per_advance_percent

      { financing_cost: @financing_cost.floor, amount_to_recieve: @amount_to_recieve.floor, excess: @excess.floor }
    rescue StandardError => e
      puts "Invalid API key or parameters, please check your inputs and try again."
      puts "For more information run with `exe/geeks --help`"
      puts e.message
    end
  end
end
