module OpenCollective
  class Response
    attr_reader :data, :error

    def initialize(data:, success:, error:)
      @data = data
      @success = success
      @error = error
    end

    def success?
      if success
        true
      else
        false
      end
    end

    private

    attr_reader :success

  end
end