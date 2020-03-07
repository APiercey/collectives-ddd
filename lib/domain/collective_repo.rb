require './lib/infrastructure/open_collective/client.rb'
require_relative './collective.rb'

module Collectives
  KNOWN_COLLECTIVES = %w[webpack jailer pizzaql typeorm witchcraft commanded]

  class CollectiveRepo
    def initialize(client:)
      @client = client
    end

    def find_by_slug(slug)
      parse_response(client.find_by_slug(slug))
    end

    def all
      fetch_collectiob_by_slugs(KNOWN_COLLECTIVES)
    end

    def find_by(spec)
      fetch_collectiob_by_slugs(KNOWN_COLLECTIVES)
        .filter { |c| spec.satisfies? c }
    end

    def known_collectives
      KNOWN_COLLECTIVES
    end

    private

    attr_reader :client

    def fetch_collectiob_by_slugs(slugs)
      slugs.map do |slug|
        Thread.new do
          parse_response(client.find_by_slug(slug))
        end
      end.map(&:value)
    end

    def parse_response(response)
      raise response.error unless response.success?

      Collectives::Collective.new(
        slug: response.data.fetch("slug"),
        currency: response.data.fetch("currency"),
        image: response.data.fetch("image"),
        balance: response.data.fetch("balance"),
        yearly_income: response.data.fetch("yearlyIncome"),
        backers_count: response.data.fetch("backersCount"),
        contributors_count: response.data.fetch("contributorsCount")
      )
    end
  end
end
