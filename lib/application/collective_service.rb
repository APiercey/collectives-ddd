# frozen_string_literal: true

require './lib/domain/collectives/upcoming_collective_specification.rb'
require './lib/domain/collectives/successful_collective_specification.rb'

# Responsible for providing Collectives under some context, such as filtering
class CollectiveService
  def initialize(collective_repo)
    @collective_repo = collective_repo

    @successful_collective_specification =
      Collectives::SuccessfulCollectiveSpecification.new
    @upcoming_collective_specification =
      Collectives::UpcomingCollectiveSpecification.new
  end

  def find_succesful_collectives
    collective_repo.find_by(successful_collective_specification)
  end

  def find_upcoming_collectives
    collective_repo.find_by(upcoming_collective_specification)
  end

  def all_collectives
    collective_repo.all
  end

  def find_by_slug(slug)
    collective_repo.find_by_slug slug
  end

  private

  attr_reader :collective_repo,
              :successful_collective_specification,
              :upcoming_collective_specification
end
