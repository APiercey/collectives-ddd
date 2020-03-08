# frozen_string_literal: true

require './lib/infrastructure/open_collective/client.rb'
require './lib/infrastructure/repo.rb'
require_relative './collective.rb'

module Collectives
  class CollectiveRepo
    include Repo
    KNOWN_COLLECTIVES =
      %w[webpack jailer pizzaql typeorm witchcraft commanded].freeze

    def initialize(client:)
      @client = client
    end

    def find_by_slug(slug)
      parse_response(client.find_by_slug(slug))
    rescue RuntimeError => e
      case e.message
      when 'Not found'
        raise EntityNotFound, "#{slug} not found"
      else
        raise e.message
      end
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

      build_collective(response.data)
    end

    def build_collective(data)
      Collectives::Collective.new(
        slug: data.fetch('slug'),
        currency: data.fetch('currency'),
        image: data.fetch('image'),
        balance: data.fetch('balance'),
        yearly_income: data.fetch('yearlyIncome'),
        backers_count: data.fetch('backersCount'),
        contributors_count: data.fetch('contributorsCount')
      )
    end
  end
end
