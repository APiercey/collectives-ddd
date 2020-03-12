# frozen_string_literal: true

require './lib/infrastructure/operation.rb'
require './lib/web/dtos/collectives/collective_dto.rb'

module Web
  module Operations
    module Collectives
      class Show
        include Operation

        def initialize(application)
          @collective_service = application.collective_service
        end

        def call(params = {})
          collective = collective_service.find_by_uuid(params.fetch('id'))
          ::Collectives::CollectiveDto.new collective
        end

        private

        attr_reader :collective_service
      end
    end
  end
end
