# frozen_string_literal: true

require './lib/infrastructure/open_collective/client.rb'
require './lib/infrastructure/open_collective/response.rb'

RSpec.describe OpenCollective::Client, :integration, :contract do
  let(:client) { described_class.new }
  let(:slug) { 'webpack' }

  describe '#find_by_slug' do
    subject(:response) { client.find_by_slug(slug) }

    context 'when the response is successful' do
      it { is_expected.to be_a_kind_of(OpenCollective::Response) }

      describe '#error' do
        subject { response.error }

        it { is_expected.to be_nil }
      end

      describe '#success?' do
        subject { response.success? }

        it { is_expected.to be_truthy }
      end

      describe '.data' do
        subject { response.data }

        it do
          is_expected.to include(
            'slug' => be_a_kind_of(String),
            'currency' => be_a_currency_code,
            'image' => start_with('http'),
            'balance' => be_a_kind_of(Integer),
            'yearlyIncome' => be_a_kind_of(Integer),
            'backersCount' => be_a_kind_of(Integer),
            'contributorsCount' => be_a_kind_of(Integer)
          )
        end
      end
    end

    context 'when the response is not successful' do
    end
  end
end
