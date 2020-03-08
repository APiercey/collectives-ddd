# frozen_string_literal: true

require './lib/domain/collectives/collective.rb'

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

  def find_by(spec)
    collectives.filter { |c| spec.satisfies? c }
  end

  private

  attr_reader :collectives
end
