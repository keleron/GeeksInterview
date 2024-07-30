# frozen_string_literal: true

module Geeks
  class Money # rubocop:disable Style/Documentation
    def self.format_number(number)
      num_groups = number.floor.to_s.chars.to_a.reverse.each_slice(3)
      "$#{num_groups.map(&:join).join(".").reverse}"
    end
  end
end
