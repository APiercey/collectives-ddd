# frozen_string_literal: true

require './lib/domain/collectives/low_contributors_specification.rb'
require './spec/helpers/specification_behaviour.rb'

RSpec.describe Collectives::LowContributorsSpecification do
  subject(:spec) { described_class.new }

  it_behaves_like 'a specification' do
    let(:valid_canidate) { build(:collective, :with_low_contributers) }
    let(:invalid_candidate) { build(:collective, :with_medium_contributers) }
  end
end
