# frozen_string_literal: true

require './lib/shared/hash_initialization.rb'

module OpenCollective
  class Response
    include HashInitialization

    attr_readable :data, :success, :error

    def success?
      success ? true : false
    end

    private

    attr_reader :success
  end
end
