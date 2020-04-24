# frozen_string_literal: true

require './lib/infrastructure/open_collective/client.rb'
require './lib/infrastructure/repo.rb'
require './lib/domain/collectives/collective.rb'
require './lib/domain/collectives/financial_report.rb'
require './lib/shared/hash_initialization.rb'

module Collectives
  class CollectiveRepo
    include Repo
    include HashInitialization

    attr_readable :client

    KNOWN_COLLECTIVES =
      {
        '7fecf338-d310-4afc-83a3-0e18bf5d935b' => 'webpack',
        'd1cd02f3-e5e5-4a05-9c2a-61239d3ca776' => 'jailer',
        '27b16df2-ca62-418b-8a41-5cfbea2affc3' => 'pizzaql',
        '691db5ef-e2f2-4cbc-a0b5-6d40d6e4e534' => 'typeorm',
        '1ca93fd8-6742-46cd-8370-69ed6f099dec' => 'witchcraft',
        'ef68869d-6a77-49d4-b5f8-c6236478eb71' => 'commanded'
      }.freeze

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
        image: data.fetch('image'),
        backers_count: data.fetch('backersCount'),
        contributors_count: data.fetch('contributorsCount'),
        yearly_income: data.fetch('yearlyIncome'),
        balance: data.fetch('balance'),
        currency: data.fetch('currency')
      )
    end
  end
end
