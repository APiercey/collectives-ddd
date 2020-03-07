require './lib/domain/successful_collective_specification.rb'
require './lib/domain/upcoming_collective_specification.rb'

class CollectiveService
  def initialize(collective_repo)
    @collective_repo = collective_repo
    @successful_collective_specification =
      Collectives::SuccessfulCollectiveSpecification.new()
    @upcoming_collective_specification =
      Collectives::UpcomingCollectiveSpecification.new()
  end

  def find_succesful_collectives
    collective_repo.all
      .select { |c| successful_collective_specification.satisfies? c }
  end

  def find_upcoming_collectives
    collective_repo
      .all
      .select { |c| upcoming_collective_specification.satisfies? c }
  end

  private

  attr_reader :collective_repo,
              :successful_collective_specification,
              :upcoming_collective_specification
end
