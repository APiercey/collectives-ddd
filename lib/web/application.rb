# frozen_string_literal: true

require './lib/infrastructure/open_collective/client.rb'
require './lib/infrastructure/collective_repo.rb'
require './lib/application/collective_service.rb'

class Application
  def open_collective_client
    @open_collective_client ||= OpenCollective::Client.new
  end

  def collective_repo
    @collective_repo ||= ::Collectives::CollectiveRepo
                         .new(client: open_collective_client)
  end

  def collective_service
    @collective_service ||= CollectiveService.new(collective_repo)
  end
end
