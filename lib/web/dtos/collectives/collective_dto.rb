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
        yearly_income: collective.yearly_income
      }
    end

    private

    attr_reader :collective
  end
end
