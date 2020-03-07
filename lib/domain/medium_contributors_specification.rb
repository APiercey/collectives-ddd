require_relative './shared/abstract_specification.rb'

module Collectives
  class MediumContributorsSpecification < AbstractSpec
    def initialize

    end

    def satisfies?(collective)
      collective.contributors_count <= 50
    end
  end
end
