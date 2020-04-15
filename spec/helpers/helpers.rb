# frozen_string_literal: true

module Helpers
  def parsed_body
    JSON.parse(last_response.body)
  end
end
