# frozen_string_literal: true

require 'faraday'
require 'json'
require_relative './response.rb'
require './lib/infrastructure/exceptions.rb'

module OpenCollective
  class Client
    SINGLE_COLLECTIVE_URL = 'https://opencollective.com/:slug.json'

    def find_by_slug(slug)
      client_response = Faraday.get(SINGLE_COLLECTIVE_URL.sub(':slug', slug))
      response_params = build_response_params(client_response)
      to_response response_params
    end

    private

    def build_response_params(response)
      case response.status
      when 200..299
        { data: JSON.parse(response.body), success: true, error: nil }
      when 404
        { data: nil, success: false, error: 'Not found' }
      else
        raise Exceptions::InternalError
      end
    end

    def to_response(data:, success:, error:)
      OpenCollective::Response.new(data: data, success: success, error: error)
    end
  end
end
