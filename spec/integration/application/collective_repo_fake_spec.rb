# frozen_string_literal: true

require './spec/support/collective_repo_fake.rb'
require './spec/support/shared_examples/collective_repo_shared_examples.rb'

RSpec.describe CollectiveRepoFake do
  include_examples 'a collective repo' do
    let(:repo) { described_class.new }
  end
end
