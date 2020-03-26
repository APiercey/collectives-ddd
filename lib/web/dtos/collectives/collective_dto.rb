# frozen_string_literal: true

require './lib/infrastructure/dto.rb'

module Collectives
  class CollectiveDto
    include Dto

    def initialize(collective)
      @collective = collective
    end

    def to_hash
      {
        slug: collective.slug,
        image: collective.image,
        contributors_count: collective.contributors_count,
        backers_count: collective.backers_count
      }
    end

    private

    attr_reader :collective
  end
end
