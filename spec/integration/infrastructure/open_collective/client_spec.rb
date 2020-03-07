require './lib/infrastructure/open_collective/client.rb'
require './lib/infrastructure/open_collective/response.rb'
require 'rspec/expectations'

RSpec.describe OpenCollective::Client do
  matcher :be_a_currency_code do
    match do |actual|
      is_correct_size = actual.length == 3
      is_upcase = actual == actual.upcase

      is_correct_size && is_upcase
    end
  end

  let(:client) { described_class.new }
  let(:slug) { "webpack" }

  describe "#find_by_slug" do
    subject(:response) { client.find_by_slug(slug) }

    it { is_expected.to be_a_kind_of(OpenCollective::Response) }

    describe "#error" do
      subject { response.error }

      it { is_expected.to be_nil }
    end

    describe "#success?" do
      subject { response.success? }

      it { is_expected.to be_truthy }
    end

    describe ".data" do
      subject { response.data }

      it do
        is_expected.to include({
          "slug" => be_a_kind_of(String),
          "currency" => be_a_currency_code,
          "image" => start_with("http"),
          "balance" => be_a_kind_of(Integer),
          "yearlyIncome" => be_a_kind_of(Integer),
          "backersCount" => be_a_kind_of(Integer),
          "contributorsCount" => be_a_kind_of(Integer)
        })
      end
    end
  end
end
