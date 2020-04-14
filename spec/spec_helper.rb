# frozen_string_literal: true

require 'factory_bot'
require './config/environment.rb'
require_relative './helpers/matchers.rb'
require 'webmock/rspec'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.example_status_persistence_file_path = './failed_specs'
  config.run_all_when_everything_filtered = true

  config.before(:suite) do
    FactoryBot.find_definitions
  end

  config.before(:each) do |example|
    WebMock.allow_net_connect! if example.metadata[:integration]
  end
end
