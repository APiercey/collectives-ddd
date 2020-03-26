# frozen_string_literal: true

module Collectives
  # A collective - models an Open Collective
  class FinancialReport
    PROPS = %i[currency balance yearly_income].freeze
    private_constant :PROPS

    attr_reader(*PROPS)

    def initialize(options = {})
      PROPS.each do |prop|
        instance_variable_set("@#{prop}", options.fetch(prop))
      end
    end
  end
end
