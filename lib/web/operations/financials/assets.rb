# frozen_string_literal: true

require './lib/infrastructure/operation.rb'
require './lib/web/dtos/financials/assets_dto.rb'

module Web
  module Operations
    module Financials
      class Assets
        def initialize(application)
          @financial_inspection_service =
            application.financial_inspection_service
        end

        def call(_params = {})
          assets = financial_inspection_service
                   .calculate_total_assets

          ::Financials::AssetsDto.new(assets)
        end

        private

        attr_reader :financial_inspection_service
      end
    end
  end
end
