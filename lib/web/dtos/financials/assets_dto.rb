# frozen_string_literal: true

require './lib/infrastructure/dto.rb'

module Financials
  class AssetsDto
    include Dto

    def initialize(assets)
      @assets = assets
    end

    def to_hash
      assets
    end

    private

    attr_reader :assets
  end
end
