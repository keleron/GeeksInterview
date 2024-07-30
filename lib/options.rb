# frozen_string_literal: true

require "date"
require "optparse"
module Geeks
  class Options # rubocop:disable Style/Documentation
    attr_accessor :options

    def initialize(argv)
      @options = {}
      parse(argv)
    end

    private

    def parse(argv) # rubocop:disable Metrics/AbcSize,Metrics/MethodLength
      parser = OptionParser.new do |opts|
        opts.banner = "Usage: script.rb [options]"
        opts.on("--client_dni CLIENT_DNI", "Client DNI") { |v| options[:client_dni] = v }
        opts.on("--debtor_dni DEBTOR_DNI", "Debtor DNI") { |v| options[:debtor_dni] = v }
        opts.on("--document_amount AMOUNT", "Document Amount") { |v| options[:document_amount] = v.to_i }
        opts.on("--folio FOLIO", "Folio") { |v| options[:folio] = v.to_i }
        opts.on("--expiration_date DATE", "Expiration Date") do |v|
          options[:expiration_date] = Date.strptime(v, "%Y-%m-%d")
          # options[:expiration_date] = v
        end
        opts.on("--api_key API_KEY", "API Key") { |v| options[:api_key] = v }
        opts.on("-h", "--help", "Show this message") do
          puts opts
          exit(0)
        end
      end
      parser.parse!(argv)
      required = %i[client_dni debtor_dni document_amount folio expiration_date api_key]
      missing = required.select { |param| options[param].nil? }
      unless missing.empty?
        puts "Missing options: #{missing.join(", ")}"
        exit(1)
      end
    rescue Date::Error
      warn "Invalid date format, should be YYYY-MM-DD"
    rescue OptionParser::ParseError => e
      warn e.message, "\n", parser
    end
  end
end
