# frozen_string_literal: true

require './lib/application/collective_repo.rb'
require './spec/support/shared_examples/collective_repo_shared_examples.rb'

RSpec.describe CollectiveRepo, :integration do
  let(:client) { OpenCollective::Client.new }

  include_examples 'a collective repo' do
    let(:repo) { described_class.new(client: client) }
  end
end
