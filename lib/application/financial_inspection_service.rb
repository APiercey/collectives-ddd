# frozen_string_literal: true

require './lib/domain/generate_financial_report_service.rb'

class FinancialInspectionService
  def initialize(collective_repo, generate_financial_report_service)
    @collective_repo = collective_repo
    @generate_financial_report_service = generate_financial_report_service
  end

  def calculate_total_assets
    generate_financial_report_service
      .call(collective_repo.all)
      .sum_of_all_assets
  end

  def calculate_collective_assets(collective_uuid)
    generate_financial_report_service
      .call([collective_repo.find_by_uuid(collective_uuid)])
      .sum_of_all_assets
  end

  private

  attr_reader :collective_repo, :generate_financial_report_service
end
