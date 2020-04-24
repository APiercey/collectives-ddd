# frozen_string_literal: true

require './lib/infrastructure/open_collective/client.rb'
require './lib/application/collective_repo.rb'
require './lib/application/collective_service.rb'
require './lib/application/financial_inspection_service.rb'
require './lib/domain/generate_financial_report_service.rb'

class ProductionApplication
  def collective_repo
    @collective_repo ||= ::Collectives::CollectiveRepo
                         .new(client: open_collective_client)
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

  private

  def open_collective_client
    @open_collective_client ||= OpenCollective::Client.new
  end
end
