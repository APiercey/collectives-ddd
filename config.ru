# frozen_string_literal: true

require './config/environment.rb'
require './lib/web/server.rb'
require './config/production_application.rb'

run Web::Server.new(ProductionApplication.new)
