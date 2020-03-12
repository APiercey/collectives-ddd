# frozen_string_literal: true

require './lib/domain/collectives/collective.rb'
require './lib/infrastructure/repo.rb'

class CollectiveRepoFake
  include Repo
  include FactoryBot::Syntax::Methods

  def initialize
    @collectives = build_collectives
  end

  def find_by_uuid(uuid)
    collective = collectives.find { |c| c.uuid.eql? uuid }

    collective || raise(EntityNotFound, "#{uuid} not found")
  end

  def all
    collectives
  end

  def known_collectives
    collectives.map(&:uuid)
  end

  def find_by(spec)
    collectives.filter { |c| spec.satisfies? c }
  end

  def add(collective)
    collectives.push collective
    true
  end

  private

  def build_collectives
    [
      build(:collective, :with_1000_usd),
      build(:collective, :with_1000_usd),
      build(:collective, :with_9000_zloty),
      build(:collective, :with_many_contributers),
      build(:collective, :with_low_contributers),
      build(:collective, :with_medium_contributers),
      build(:collective, :with_high_contributers)
    ]
  end

  attr_reader :collectives
end
