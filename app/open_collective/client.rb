require 'faraday'
require 'json'
require_relative './response.rb'

module OpenCollective
  class Client
    SINGLE_COLLECTIVE_URL = 'https://opencollective.com/:slug.json'

    def find_by_slug(slug)
      response = Faraday.get(SINGLE_COLLECTIVE_URL.sub ':slug', slug)
      to_response response
    end

    private

    def to_response(response)
      case response.status
      when 200..299
        OpenCollective::Response.new(
          data: JSON.parse(response.body),
          success: true,
          error: nil
        )
      else
        OpenCollective::Response.new(
          data: nil,
          success: false,
          error: "Some error occurred"
        )
      end
    end
  end
end
