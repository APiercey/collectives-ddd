require './specs/helpers/collective_repo_fake.rb'
require_relative './collective_repo_shared_examples.rb'

RSpec.describe CollectiveRepoRake do
  include_examples "a collective repo" do
    let(:repo) { described_class.new() }
  end
end
