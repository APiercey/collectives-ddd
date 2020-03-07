require './lib/domain/high_contributors_specification.rb'
require './spec/helpers/specification_behaviour.rb'

RSpec.describe Collectives::HighContributorsSpecification do
  subject(:spec) { described_class.new }

  it_behaves_like 'a specification' do
    let(:valid_canidate) { build(:collective, :with_high_contributers) }
    let(:invalid_candidate) { build(:collective, :with_viral_contributers) }
  end
end
