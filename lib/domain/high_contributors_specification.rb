require_relative './shared/abstract_specification.rb'

module Collectives
  class HighContributorsSpecification < AbstractSpec
    def initialize

    end

    def satisfies?(collective)
      collective.contributors_count <= 200
    end
  end
end
