# frozen_string_literal: true

require './lib/infrastructure/operation.rb'
require './lib/web/dtos/collectives/collective_dto.rb'

module Web
  module Operations
    module Collectives
      class Index
        include Operation

        def initialize(application)
          @collective_service = application.collective_service
        end

        def call(_params = {})
          collective_service
            .all_collectives
            .map { |c| ::Collectives::CollectiveDto.new c }
        end

        private

        attr_reader :collective_service
      end
    end
  end
end
