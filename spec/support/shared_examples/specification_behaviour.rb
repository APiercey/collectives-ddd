# frozen_string_literal: true

RSpec.shared_examples 'a specification' do
  it { is_expected.to respond_to(:and).with(1).argument }
  it { is_expected.to respond_to(:or).with(1).argument }
  it { is_expected.to respond_to(:not).with(1).argument }
  it { is_expected.to respond_to(:satisfies?).with(1).argument }

  describe '#satisifes?' do
    describe 'valid canidate satisfies' do
      subject { spec.satisfies? valid_canidate }

      it { is_expected.to be_truthy }
    end

    describe 'invalid canidate does not satisfy' do
      subject { spec.satisfies? invalid_candidate }

      it { is_expected.to be_falsy }
    end
  end
end
