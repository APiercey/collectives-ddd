# frozen_string_literal: true

require './lib/domain/collectives/collective.rb'

FactoryBot.define do
  factory :collective, class: Collectives::Collective do
    sequence(:uuid) { |n| "uuid-#{n}" }
    sequence(:slug) { |n| "slug-#{n}" }
    currency { 'EUR' }
    image { 'http://example.com/test.png' }
    balance { 950 }
    yearly_income { 2000 }
    backers_count { 100 }
    contributors_count { 100 }

    initialize_with { new(attributes) }

    trait :with_1000_usd do
      balance { 1000 }
      currency { 'USD' }
    end

    trait :with_9000_zloty do
      balance { 9000 }
      currency { 'PLN' }
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
