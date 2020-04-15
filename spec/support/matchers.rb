# frozen_string_literal: true

require 'rspec/expectations'

RSpec::Matchers.define :be_a_currency_code do
  match do |actual|
    expect(actual.length).to eql(3)
    expect(actual).to eql(actual.upcase)
  end
end

RSpec::Matchers.define :be_a_uuid_4 do
  match do |actual|
    expect(actual).to match(/[a-f0-9]{8}-([a-f0-9]{4}-){3}[a-f0-9]{12}/)
  end
end

RSpec::Matchers.define :have_json_header do
  match do |actual|
    expect(actual.headers['Content-Type']).to eql('application/json')
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
