# frozen_string_literal: true

require './lib/shared/hash_initialization.rb'

module Collectives
  # A collective - models an Open Collective
  class Collective
    include HashInitialization

    attr_readable :uuid, :slug, :image, :backers_count,
                  :contributors_count, :financial_report
  end
end
