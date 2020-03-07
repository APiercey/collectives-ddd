require './spec/helpers/collective_repo_fake.rb'
require './lib/application/collective_service.rb'

RSpec.describe CollectiveService do
  let(:collective_with_high_contributers) do
    build(:collective, :with_high_contributers)
  end

  let(:collective_with_medium_contributers) do
    build(:collective, :with_medium_contributers)
  end

  let(:collective_repo) do
    CollectiveRepoFake.new([collective_with_medium_contributers,
                            collective_with_high_contributers])
  end

  subject(:service) { described_class.new(collective_repo) }

  describe "#find_succesful_collectives" do
    subject { service.find_succesful_collectives }

    it { is_expected.to contain_exactly(collective_with_high_contributers) }
  end

  describe "#find_upcoming_collectives" do
    subject { service.find_upcoming_collectives }

    it { is_expected.to contain_exactly(collective_with_medium_contributers) }
  end
end
