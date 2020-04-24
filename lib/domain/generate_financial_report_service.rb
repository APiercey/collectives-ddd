# frozen_string_literal: true

require_relative './collectives/financial_report.rb'

class GenerateFinancialReport
  def call(collectives)
    financial_report = Collectives::FinancialReport.new

    collectives
      .map(&:asset)
      .map { |asset| financial_report.add_asset(asset) }

    financial_report
  end
end
