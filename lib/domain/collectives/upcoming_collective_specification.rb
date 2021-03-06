# frozen_string_literal: true

require './lib/domain/shared/abstract_specification.rb'

module Collectives
  class UpcomingCollectiveSpecification < AbstractSpec
    def satisfies?(collective)
      collective.contributors_count > 3 &&
        collective.contributors_count <= 50
    end
  end
end
