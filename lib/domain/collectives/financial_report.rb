# frozen_string_literal: true

require './lib/shared/hash_initialization.rb'

module Collectives
  # A collective - models an Open Collective
  class FinancialReport
    include HashInitialization

    attr_readable :currency, :balance, :yearly_income
  end
end
