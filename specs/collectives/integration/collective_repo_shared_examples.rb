require './app/collectives/collective.rb'

RSpec.shared_examples "a collective repo" do
  describe "#find_by_slug" do
    let(:collective_slug) { repo.known_collectives.sample }

    subject { repo.find_by_slug(collective_slug) }

    it { is_expected.to be_a_kind_of(Collectives::Collective) }
  end

  describe "#all" do
    subject { repo.all }

    it { is_expected.to be_an Enumerable }
    it { is_expected.not_to be_empty }
    it { is_expected.to all be_a(Collectives::Collective) }
  end
end
