require './spec/spec_helper'
require './spec/helpers/collective_repo_fake.rb'
require './lib/application/collective_service.rb'

RSpec.describe CollectiveService do
  let(:collective_with_many_contributers) do
    build(:collective, :with_many_contributers)
  end

  let(:collective_with_few_contributers) do
    build(:collective, :with_few_contributers)
  end

  let(:collective_repo) do
    CollectiveRepoFake.new([collective_with_few_contributers,
                            collective_with_many_contributers])
  end

  subject(:service) { described_class.new(collective_repo) }

  describe "#find_succesful_collectives" do
    subject { service.find_succesful_collectives }

    it { is_expected.to contain_exactly(collective_with_many_contributers) }
  end

  describe "#find_upcoming_collectives" do
    subject { service.find_upcoming_collectives }

    it { is_expected.to contain_exactly(collective_with_few_contributers) }
  end
end
