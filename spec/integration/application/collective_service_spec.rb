# frozen_string_literal: true

require './config/production_application.rb'

RSpec.describe CollectiveService do
  let(:application) { ProductionApplication.new }
  let(:collective_repo) { application.collective_repo }

  subject(:service) { described_class.new(collective_repo) }

  describe '.find_succesful_collectives' do
    subject { service.find_succesful_collectives }

    before do
      allow(collective_repo).to receive(:find_by_uuid).and_return(true)
    end

    it { is_expected.to be_falsey }
  end
end
