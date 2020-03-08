# frozen_string_literal: true

require './lib/domain/assets_service.rb'

RSpec.describe AssetsService do
  subject(:service) { described_class.new }
  let(:collectives) do
    [
      build(:collective, :with_1000_usd),
      build(:collective, :with_1000_usd),
      build(:collective, :with_9000_zloty)
    ]
  end

  describe '#asset_sums_by_currency' do
    subject { service.asset_sums_by_currency collectives }

    it do
      is_expected.to include(
        'USD' => 2000,
        'PLN' => 9000
      )
    end
  end
end
