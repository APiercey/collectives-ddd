require_relative './shared/abstract_specification.rb'

module Collectives
  class SuccessfulCollectiveSpecification < AbstractSpec
    def satisfies?(collective)
      collective.contributors_count > 51 &&
      collective.contributors_count <= 200
    end
  end
end
