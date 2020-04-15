# frozen_string_literal: true

require 'rspec/expectations'

RSpec::Matchers.define :be_a_currency_code do
  match do |actual|
    is_correct_size = actual.length == 3
    is_upcase = actual == actual.upcase

    is_correct_size && is_upcase
  end
end

RSpec::Matchers.define :have_json_header do
  match do |actual|
    actual.headers['Content-Type'] == 'application/json'
  end
end

RSpec::Matchers.define :have_status do |expected|
  match do |actual|
    expect(actual.status).to eql(expected)
  end
end

RSpec::Matchers.define :match_schema do |expected|
  match do |actual|
    expect(actual).to include(expected)
  end
end
