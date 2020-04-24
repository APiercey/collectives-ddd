# frozen_string_literal: true

module Collectives
  class Asset
    attr_reader :balance, :currency

    def initialize(args)
      @balance = args.fetch(:balance)
      @currency = args.fetch(:currency)
    end
  end
end
