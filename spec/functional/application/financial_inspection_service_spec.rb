# frozen_string_literal: true

require './lib/application/financial_inspection_service.rb'
require './lib/domain/assets_service.rb'
require './spec/helpers/collective_repo_fake.rb'

RSpec.describe FinancialInspectionService do
  let(:collective_repo) { CollectiveRepoFake.new }
  let(:assets_service) { AssetsService.new }
  let(:service) { described_class.new(collective_repo, assets_service) }

  let(:collective_with_usd) { build(:collective, :with_1000_usd) }

  before do
    collective_repo.add collective_with_usd
  end

  describe '#calculate_total_assets' do
    subject { service.calculate_total_assets }

    it { is_expected.to include('USD' => a_value >= 1000) }
  end

  describe '#calculate_collective_assets' do
    subject { service.calculate_collective_assets collective_with_usd.uuid }

    it { is_expected.to include('USD' => 1000) }
  end
end
