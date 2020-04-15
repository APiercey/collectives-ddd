# frozen_string_literal: true

require './lib/domain/collectives/collective.rb'
require 'securerandom'

FactoryBot.define do
  factory :collective, class: Collectives::Collective do
    sequence(:uuid) { |_n| SecureRandom.uuid }
    sequence(:slug) { |n| "slug-#{n}" }
    image { 'http://example.com/test.png' }
    backers_count { 100 }
    contributors_count { 100 }
    financial_report { build(:financial_report) }

    initialize_with { new(attributes) }

    trait :with_1000_usd do
      financial_report { build(:financial_report, :with_1000_usd) }
    end

    trait :with_9000_zloty do
      financial_report { build(:financial_report, :with_9000_zloty) }
    end

    trait :with_many_contributers do
      contributors_count { 1000 }
    end

    trait :with_low_contributers do
      contributors_count { 3 }
    end

    trait :with_medium_contributers do
      contributors_count { 50 }
    end

    trait :with_high_contributers do
      contributors_count { 200 }
    end

    trait :with_viral_contributers do
      contributors_count { 201 }
    end
  end
end
