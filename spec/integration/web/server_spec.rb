# frozen_string_literal: true

require 'rack/test'
require './lib/web/server.rb'
require './spec/support/test_application.rb'
require './lib/infrastructure/exceptions.rb'

class TestServer < Web::Server
  get '/internal_error_route' do
    raise Exceptions::InternalError
  end
end

RSpec.describe TestServer do
  include Rack::Test::Methods

  def app
    described_class.new(TestApplication.new)
  end

  describe 'Exceptions::InternalError' do
    subject { last_response }

    before { get '/internal_error_route' }

    it { is_expected.to have_status 422 }
    it { should have_json_header }

    describe 'body' do
      subject { parsed_body }

      it do
        is_expected.to include('code' => 422, 'message' => a_kind_of(String))
      end
    end
  end
end
