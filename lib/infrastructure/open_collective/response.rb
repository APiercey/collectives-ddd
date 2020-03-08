# frozen_string_literal: true

module OpenCollective
  class Response
    attr_reader :data, :error

    def initialize(data:, success:, error:)
      @data = data
      @success = success
      @error = error
    end

    def success?
      success ? true : false
    end

    private

    attr_reader :success
  end
end
