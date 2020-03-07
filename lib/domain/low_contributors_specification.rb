require_relative './shared/abstract_specification.rb'

module Collectives
  class LowContributorsSpecification < AbstractSpec
    def initialize

    end

    def satisfies?(collective)
      collective.contributors_count <= 3
    end
  end
end
