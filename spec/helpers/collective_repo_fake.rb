require './lib/domain/collective.rb'

class CollectiveRepoFake
  def initialize(collectives)
    @collectives = collectives
  end

  def find_by_slug(slug)
    collectives.find { |c| c.slug.eql? slug }
  end

  def all
    collectives
  end

  def known_collectives
    collectives.map(&:slug)
  end

  private

  attr_reader :collectives
end
