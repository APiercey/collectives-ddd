# frozen_string_literal: true

require_relative './asset.rb'

module Collectives
  # A collective - models an Open Collective
  class Collective
    attr_reader :uuid, :slug, :image, :backers_count
    attr_reader :contributors_count, :yearly_income, :asset

    def initialize(args)
      @uuid = args.fetch(:uuid)
      @slug = args.fetch(:slug)
      @image = args.fetch(:image)
      @backers_count = args.fetch(:backers_count)
      @contributors_count = args.fetch(:contributors_count)
      @yearly_income = args.fetch(:yearly_income)
      @asset = Asset.new(
        balance: args.fetch(:balance),
        currency: args.fetch(:currency)
      )
    end
  end
end
