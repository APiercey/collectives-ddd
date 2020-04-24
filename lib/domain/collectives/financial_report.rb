# frozen_string_literal: true

require_relative './asset.rb'

module Collectives
  # A collective - models an Open Collective
  class FinancialReport
    def initialize
      @assets = []
    end

    def add_asset(asset)
      return false unless asset.balance.positive?

      assets << asset
      true
    end

    def sum_of_all_assets
      assets
        .group_by(&:currency)
        .map do |currency, grouped_assets|
          { currency => grouped_assets.sum(&:balance) }
        end
        .reduce({}, :merge)
    end

    private

    attr_reader :assets
  end
end
