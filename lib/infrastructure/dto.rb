# frozen_string_literal: true

require 'json'

module Dto
  def to_json(*_args)
    to_hash.to_json
  end
end
