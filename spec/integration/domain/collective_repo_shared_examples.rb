# frozen_string_literal: true

require './lib/domain/collectives/collective.rb'

RSpec.shared_examples 'a collective repo' do
  subject { repo }

  it { is_expected.to respond_to(:find_by_slug).with(1).argument }
  it { is_expected.to respond_to(:all).with(0).argument }
  it { is_expected.to respond_to(:find_by).with(1).argument }
  it { is_expected.to respond_to(:known_collectives).with(0).argument }

  describe '#find_by_slug' do
    let(:collective_slug) { repo.known_collectives.sample }

    subject { repo.find_by_slug(collective_slug) }

    it { is_expected.to be_a_kind_of(Collectives::Collective) }
  end

  describe '#all' do
    subject { repo.all }

    it { is_expected.to be_an Enumerable }
    it { is_expected.not_to be_empty }
    it { is_expected.to all be_a(Collectives::Collective) }
  end

  describe '#find_by' do
    let(:spec) do
      Class.new do
        def initialize(slug)
          @slug = slug
        end

        def satisfies?(collective)
          collective.slug == @slug
        end
      end.new(repo.known_collectives.sample)
    end

    subject { repo.find_by spec }

    it { is_expected.to be_an Enumerable }
    it { is_expected.not_to be_empty }
    it { is_expected.to all be_a(Collectives::Collective) }
  end
end
