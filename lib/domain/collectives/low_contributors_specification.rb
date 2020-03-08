require_relative './shared/abstract_specification.rb'

module Collectives
  class LowContributorsSpecification < AbstractSpec
    def satisfies?(collective)
      collective.contributors_count > 0 &&
      collective.contributors_count <= 3
    end
  end
end
