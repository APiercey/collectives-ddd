# frozen_string_literal: true

require 'rack/test'
require './lib/web/server.rb'
require './spec/support/test_application.rb'
require './spec/support/shared_examples/a_get_endpoint.rb'

RSpec.describe Web::Server do
  include Rack::Test::Methods

  def app
    described_class.new(application)
  end

  let(:application) { TestApplication.new }
  let(:sample_collective) { application.collective_repo.all.sample }

  let(:collective_schema) do
    {
      'id' => be_a_uuid_4,
      'contributors_count' => a_value > -1,
      'slug' => a_kind_of(String),
      'image' => match(/http/),
      'backers_count' => a_value > -1
    }
  end

  describe 'GET /collectives' do
    before { get '/collectives' }

    it_behaves_like 'a get endpoint'

    describe 'body' do
      subject { parsed_body }

      it { is_expected.to be_an Enumerable }
      it { is_expected.to all(match_schema(collective_schema)) }
    end
  end

  describe 'GET /collectives/:id' do
    before { get "/collectives/#{sample_collective.uuid}" }

    it_behaves_like 'a get endpoint'

    describe 'body' do
      subject { parsed_body }

      it { is_expected.to match_schema(collective_schema) }
    end
  end

  describe 'GET /assets' do
    before { get '/assets' }

    it_behaves_like 'a get endpoint'

    describe 'body' do
      subject { parsed_body }

      it { is_expected.not_to be_nil }

      it 'returns a list of assets' do
        is_expected.to include(
          'USD' => 2000,
          'PLN' => 9000,
          'EUR' => 3800
        )
      end
    end
  end

  describe 'GET /collectives/:id/assets' do
    before { get "/collectives/#{sample_collective.uuid}/assets" }

    it_behaves_like 'a get endpoint'

    describe 'body' do
      subject { parsed_body }

      let(:report) { sample_collective.financial_report }

      it 'returns the correct assets' do
        is_expected.to include(report.currency => report.balance)
      end
    end
  end
end
