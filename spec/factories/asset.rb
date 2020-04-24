# frozen_string_literal: true

require './lib/domain/collectives/asset.rb'

FactoryBot.define do
  factory :asset, class: Collectives::Asset do
    currency { 'EUR' }
    balance { 1000 }

    initialize_with { new(attributes) }
  end
end
