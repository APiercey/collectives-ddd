require './lib/domain/collective.rb'

FactoryBot.define do
  factory :collective, class: Collectives::Collective do
    sequence(:slug) { |n| "slug_#{n}" }
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

    trait :with_few_contributers do
      contributors_count { 7 }
    end
  end
end
