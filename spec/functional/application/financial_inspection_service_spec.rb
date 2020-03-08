# frozen_string_literal: true

require './lib/application/financial_inspection_service.rb'
require './spec/helpers/collective_repo_fake.rb'

RSpec.describe FinancialInspectionService do
  let(:collective_repo) { CollectiveRepoFake.new }

  subject(:service) { described_class.new(collective_repo) }

  describe '#calculate_total_assets' do
    subject { service.calculate_total_assets }

    it do
      is_expected.to include('USD' => a_value > 0)
    end
  end
end
