# frozen_string_literal: true

require './lib/domain/collectives/financial_report.rb'

FactoryBot.define do
  factory :financial_report, class: Collectives::FinancialReport do
    currency { 'EUR' }
    balance { 950 }

    initialize_with { new(attributes) }
  end
end
