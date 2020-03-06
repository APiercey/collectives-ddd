require './app/collectives/collective.rb'

class CollectiveRepoRake
  KNOWN_COLLECTIVES = %w[webpack elixir home ruby]

  def initialize(*args)
    @collectives = KNOWN_COLLECTIVES.map do |slug|
      Collectives::Collective.new(slug: slug)
    end
  end

  def find_by_slug(slug)
    collectives.find { |c| c.slug.eql? slug }
  end

  def all
    collectives
  end

  def known_collectives
    KNOWN_COLLECTIVES
  end

  private

  attr_reader :collectives
end
