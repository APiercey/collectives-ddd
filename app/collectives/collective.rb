module Collectives
  class Collective
    attr_reader :slug, :currency, :image, :balance,
                :yearly_income, :backers_count, :contributors_count

    def initialize(options = {})
      options.each do |k,v|
        instance_variable_set("@#{k}", v)
      end
    end
  end
end
