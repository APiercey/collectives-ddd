# frozen_string_literal: true

require './lib/infrastructure/open_collective/client.rb'
require './lib/infrastructure/repo.rb'
require './lib/domain/collectives/collective.rb'

module Collectives
  class CollectiveRepo
    include Repo
    KNOWN_COLLECTIVES =
      {
        'uuid-1' => 'webpack',
        'uuid-2' => 'jailer',
        'uuid-3' => 'pizzaql',
        'uuid-4' => 'typeorm',
        'uuid-5' => 'witchcraft',
        'uuid-6' => 'commanded'
      }.freeze

    def initialize(client:)
      @client = client
    end

    def find_by_uuid(uuid)
      response = client.find_by_slug(get_slug(uuid))
      parse_response(uuid, response)
    rescue RuntimeError => e
      case e.message
      when 'Not found'
        raise EntityNotFound, "#{uuid} not found"
      else
        raise e.message
      end
    end

    def all
      fetch_collection_by_uuids(KNOWN_COLLECTIVES.keys)
    end

    def find_by(spec)
      fetch_collection_by_uuids(KNOWN_COLLECTIVES.keys)
        .filter { |c| spec.satisfies? c }
    end

    def known_collectives
      KNOWN_COLLECTIVES.keys
    end

    private

    attr_reader :client

    def get_slug(uuid)
      KNOWN_COLLECTIVES.fetch(uuid)
    rescue KeyError
      raise EntityNotFound, "#{uuid} not found"
    end

    def fetch_collection_by_uuids(uuids)
      uuids.map do |uuid|
        Thread.new do
          slug = get_slug(uuid)
          response = client.find_by_slug(slug)
          parse_response(uuid, response)
        end
      end.map(&:value)
    end

    def parse_response(uuid, response)
      raise response.error unless response.success?

      build_collective(uuid, response.data)
    end

    def build_collective(uuid, data)
      Collectives::Collective.new(
        uuid: uuid,
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
