# frozen_string_literal: true

require './lib/domain/assets_service.rb'

class FinancialInspectionService
  def initialize(collective_repo, assets_service)
    @collective_repo = collective_repo
    @assets_service = assets_service
  end

  def calculate_total_assets
    assets_service.asset_sums_by_currency collective_repo.all
  end

  private

  attr_reader :collective_repo, :assets_service
end
