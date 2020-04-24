# frozen_string_literal: true

require './spec/support/collective_repo_fake.rb'
require './lib/application/collective_service.rb'
require './lib/application/financial_inspection_service.rb'
require './lib/domain/generate_financial_report_service.rb'

class TestApplication
  def collective_repo
    @collective_repo ||= CollectiveRepoFake.new
  end

  def generate_financial_report_service
    @generate_financial_report_service ||= GenerateFinancialReport.new
  end

  def collective_service
    @collective_service ||= CollectiveService.new(collective_repo)
  end

  def financial_inspection_service
    @financial_inspection_service ||= FinancialInspectionService
                                      .new(collective_repo, generate_financial_report_service)
  end
end
