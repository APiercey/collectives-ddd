RSpec.shared_examples "a specification" do
  describe "#satisifes?" do
    describe 'canidate satisfies' do
      subject { spec.satisfies? valid_canidate }

      it { is_expected.to be_truthy }
    end

    describe 'canidate does not satisfy' do
      subject { spec.satisfies? invalid_candidate }

      it { is_expected.to be_falsy }
    end
  end
end
