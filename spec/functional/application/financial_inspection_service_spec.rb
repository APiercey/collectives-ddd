require './lib/application/financial_inspection_service.rb'
require './spec/helpers/collective_repo_fake.rb'

RSpec.describe FinancialInspectionService do
  let(:collectives_collection) do
    [
      build(:collective, :with_1000_usd),
      build(:collective, :with_1000_usd),
      build(:collective, :with_9000_zloty)
    ]
  end

  let(:collective_repo) do
    CollectiveRepoFake.new(collectives_collection)
  end

  subject(:service) { described_class.new(collective_repo) }

  describe "#calculate_total_assets" do
    subject { service.calculate_total_assets }

    it do
      is_expected.to include(
        "USD" => 2000,
        "PLN" => 9000
      )
    end
  end
end
