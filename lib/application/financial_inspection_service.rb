# frozen_string_literal: true

class FinancialInspectionService
  def initialize(collective_repo)
    @collective_repo = collective_repo
  end

  def calculate_total_assets
    collective_repo.all
                   .group_by(&:currency)
                   .map { |currency, collectives| { currency => collectives.sum(&:balance) } }
                   .reduce({}, :merge)
  end

  private

  attr_reader :collective_repo
end
