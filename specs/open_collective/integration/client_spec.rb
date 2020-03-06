require './app/open_collective/client.rb'
require './app/open_collective/response.rb'

RSpec.describe OpenCollective::Client do
  let(:client) { described_class.new }
  let(:slug) { "webpack" }

  describe "#find_by_slug" do
    subject { client.find_by_slug(slug) }

    it { is_expected.to be_a_kind_of(OpenCollective::Response)}

        .and have_attributes(:error => nil, :success? => true)
      expect(subject.success?).to be true
      expect(subject.success?).to be true
    end
  end
end
