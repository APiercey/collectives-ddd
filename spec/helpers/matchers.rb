# frozen_string_literal: true

require 'rspec/expectations'

RSpec::Matchers.define :be_a_currency_code do
  match do |actual|
    is_correct_size = actual.length == 3
    is_upcase = actual == actual.upcase

    is_correct_size && is_upcase
  end
end
