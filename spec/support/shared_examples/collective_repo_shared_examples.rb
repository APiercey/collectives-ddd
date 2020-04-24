# frozen_string_literal: true

require './lib/domain/collectives/collective.rb'
require './lib/infrastructure/exceptions.rb'

RSpec.shared_examples 'a collective repo' do
  subject { repo }

  it { is_expected.to respond_to(:find_by_uuid).with(1).argument }
  it { is_expected.to respond_to(:all).with(0).argument }
  it { is_expected.to respond_to(:find_by).with(1).argument }
  it { is_expected.to respond_to(:known_collectives).with(0).argument }

  describe '#find_by_uuid' do
    subject { repo.find_by_uuid(collective_uuid) }

    context 'when collective exists' do
      let(:collective_uuid) { repo.known_collectives.sample }

      it { is_expected.to be_a_kind_of(Collectives::Collective) }
    end

    context 'when collective does not exists' do
      let(:collective_uuid) { 'uuid-that-does-not-exist' }

      it 'raises a Repo::EntityNotFound error' do
        expect { subject }
          .to raise_error(Exceptions::EntityNotFound)
          .with_message(/#{collective_uuid}/)
      end
    end
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
        def initialize(id)
          @id = id
        end

        def satisfies?(collective)
          collective.uuid == @id
        end
      end.new(repo.known_collectives.sample)
    end

    subject { repo.find_by spec }

    it { is_expected.to be_an Enumerable }
    it { is_expected.not_to be_empty }
    it { is_expected.to all be_a(Collectives::Collective) }
  end
end
