# frozen_string_literal: true

require './lib/web/server.rb'

# This class inherits from Web::Server to provide to real server
# and a convienent way to include anything needed for testing
#
# e.g. Adding a route that is gaurenteed to fail with a specific
# error class, to assert error handling is working in the server
class TestServer < Web::Server
  get '/internal_error_route' do
    raise Exceptions::InternalError
  end
end
