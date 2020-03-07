require './spec/helpers/collective_repo_fake.rb'
require_relative './collective_repo_shared_examples.rb'

RSpec.describe CollectiveRepoFake do
  let(:collectives_collection) do
    (1..3).map { |_| build(:collective) }
  end

  include_examples "a collective repo" do
    let(:repo) { described_class.new(collectives_collection) }
  end
end
