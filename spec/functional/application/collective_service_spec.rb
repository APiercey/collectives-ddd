# frozen_string_literal: true

require './spec/helpers/collective_repo_fake.rb'
require './lib/application/collective_service.rb'

RSpec.describe CollectiveService do
  let(:collective_with_high_contributers) do
    build(:collective, :with_high_contributers)
  end

  let(:collective_with_medium_contributers) do
    build(:collective, :with_medium_contributers)
  end

  let(:collective_repo) { CollectiveRepoFake.new }

  subject(:service) { described_class.new(collective_repo) }

  before do
    [collective_with_high_contributers,
     collective_with_medium_contributers].each do |collective|
      collective_repo.add(collective)
    end
  end

  describe '#find_succesful_collectives' do
    subject { service.find_succesful_collectives }

    it { is_expected.to include(collective_with_high_contributers) }
    it { is_expected.not_to include(collective_with_medium_contributers) }
  end

  describe '#find_upcoming_collectives' do
    subject { service.find_upcoming_collectives }

    it { is_expected.to include(collective_with_medium_contributers) }
    it { is_expected.not_to include(collective_with_high_contributers) }
  end
end
