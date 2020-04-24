# frozen_string_literal: true

require 'rack/test'

RSpec.shared_examples 'a get endpoint' do
  subject { last_response }

  it { should be_ok }
  it { should have_json_header }
end
