# frozen_string_literal: true

module Collectives
  # A collective - models an Open Collective
  class Collective
    attr_reader :uuid, :slug, :currency, :image, :balance,
                :yearly_income, :backers_count, :contributors_count

    def initialize(options = {})
      options.each do |k, v|
        instance_variable_set("@#{k}", v)
      end
    end
  end
end
