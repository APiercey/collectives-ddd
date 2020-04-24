# frozen_string_literal: true

require './lib/domain/collectives/financial_report.rb'
require './lib/domain/collectives/asset.rb'

RSpec.describe Collectives::FinancialReport do
  let(:financial_report) { described_class.new }

  describe '#add_asset' do
    it 'returns true an asset is added' do
      result = financial_report.add_asset(build(:asset, balance: 1000))

      expect(result).to eql(true)
    end

    it 'returns false when asset balance is lower than 1' do
      result = financial_report.add_asset(build(:asset, balance: 0))

      expect(result).to eql(false)
    end
  end

  describe '#sum_of_all_assets' do
    before do
      [['EUR', 1300],
       ['EUR', 4000],
       ['PLN', 56_000],
       ['PLN', 30_000],
       ['USD', 1000],
       ['USD', 2000],
       ['CAN', 9000]]
        .map { |c, b| build(:asset, currency: c, balance: b) }
        .map { |asset_hash| financial_report.add_asset asset_hash }
    end

    it 'produces the correct sum' do
      result = financial_report.sum_of_all_assets

      expect(result).to include(
        'EUR' => 5300,
        'PLN' => 86_000,
        'USD' => 3000,
        'CAN' => 9000
      )
    end
  end
end
