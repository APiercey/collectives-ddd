# frozen_string_literal: true

require './lib/domain/shared/abstract_specification.rb'

module Collectives
  class LowContributorsSpecification < AbstractSpec
    def satisfies?(collective)
      collective.contributors_count.positive? &&
        collective.contributors_count <= 3
    end
  end
end
