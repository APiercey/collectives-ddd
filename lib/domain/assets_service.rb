# frozen_string_literal: true

class AssetsService
  def asset_sums_by_currency(collectives)
    collectives
      .group_by(&:currency)
      .map do |currency, grouped_collectives|
        { currency => grouped_collectives.sum(&:balance) }
      end
      .reduce({}, :merge)
  end
end
