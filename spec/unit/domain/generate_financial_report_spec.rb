# frozen_string_literal: true

require './lib/domain/generate_financial_report_service'
require './lib/domain/collectives/financial_report.rb'

RSpec.describe GenerateFinancialReport do
  let(:service) { described_class.new }

  let(:collectives) do
    [
      build(:collective, :with_1000_usd),
      build(:collective, :with_1000_usd),
      build(:collective, :with_9000_zloty)
    ]
  end

  describe '#call' do
    subject { service.call collectives }

    it { is_expected.to be_a_kind_of(Collectives::FinancialReport) }
  end
end
