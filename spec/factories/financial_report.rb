# frozen_string_literal: true

require './lib/domain/collectives/financial_report.rb'

FactoryBot.define do
  factory :financial_report, class: Collectives::FinancialReport do
    currency { 'EUR' }
    balance { 950 }
    yearly_income { 2000 }

    initialize_with { new(attributes) }

    trait :with_1000_usd do
      balance { 1000 }
      currency { 'USD' }
    end

    trait :with_9000_zloty do
      balance { 9000 }
      currency { 'PLN' }
    end
  end
end
