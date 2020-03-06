require './lib/domain/collective_repo.rb'
require_relative './collective_repo_shared_examples.rb'

RSpec.describe Collectives::CollectiveRepo do
  let(:client) { OpenCollective::Client.new }

  include_examples "a collective repo" do
    let(:repo) { described_class.new(client: client) }
  end
end
