# frozen_string_literal: true

require 'rack/test'
require './spec/helpers/test_server.rb'
require './spec/helpers/test_application.rb'
require './lib/infrastructure/exceptions.rb'

RSpec.describe TestServer do
  include Rack::Test::Methods

  def app
    described_class.new(application)
  end

  let(:application) { TestApplication.new }
  let(:sample_collective) { application.collective_repo.all.sample }

  shared_examples 'a get endpoint' do
    it 'returns status 200' do
      expect(result.status).to eq 200
    end

    it 'returns Content-Type as application/json' do
      header = result.headers['Content-Type']

      expect(header).to be_truthy.and eql('application/json')
    end
  end

  shared_examples 'object matches collective schema' do
    it 'returns a matching collective' do
      expect(result_collective).not_to be_nil

      expect(result_collective).to include(
        'contributors_count' => collective.contributors_count,
        'slug' => collective.slug,
        'image' => collective.image,
        'backers_count' => collective.backers_count
      )
    end
  end

  describe 'GET /collectives' do
    subject { get '/collectives' }

    it_behaves_like 'a get endpoint' do
      let(:result) { subject }
    end

    describe 'body' do
      let(:result) { JSON.parse(subject.body) }

      it_behaves_like 'object matches collective schema' do
        let(:result_collective) do
          result.find { |c| c['id'] == collective.uuid }
        end

        let(:collective) { sample_collective }
      end

      it 'returns a collection' do
        expect(result).to be_an Enumerable
      end
    end
  end

  describe 'GET /collectives/:id' do
    subject { get "/collectives/#{sample_collective.uuid}" }

    it_behaves_like 'a get endpoint' do
      let(:result) { subject }
    end

    describe 'body' do
      it_behaves_like 'object matches collective schema' do
        let(:result_collective) { JSON.parse(subject.body) }
        let(:collective) { sample_collective }
      end
    end
  end

  describe 'GET /assets' do
    subject { get '/assets' }

    it_behaves_like 'a get endpoint' do
      let(:result) { subject }
    end

    describe 'body' do
      let(:result) { JSON.parse(subject.body) }

      it 'returns a list of assets' do
        expect(result).not_to be_nil

        expect(result).to include(
          'USD' => 2000,
          'PLN' => 9000,
          'EUR' => 3800
        )
      end
    end
  end

  context 'when an error occurs' do
    describe 'Exceptions::InternalError' do
      let(:result) { get '/internal_error_route' }

      it 'it returns status 422' do
        expect(result.status).to eq 422
      end

      it 'returns Content-Type as application/json' do
        header = result.headers['Content-Type']

        expect(header).to be_truthy.and eql('application/json')
      end

      it 'provides a body' do
        expect(JSON.parse(result.body))
          .to include('code' => 422, 'message' => a_kind_of(String))
      end
    end
  end

  describe 'GET /collectives/:id/assets' do
    subject { get "/collectives/#{sample_collective.uuid}/assets" }

    it_behaves_like 'a get endpoint' do
      let(:result) { subject }
    end

    describe 'body' do
      let(:result) { JSON.parse(subject.body) }

      it 'returns the correct assets' do
        report = sample_collective.financial_report
        expect(result).to include(report.currency => report.balance)
      end
    end
  end
end
