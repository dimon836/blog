FactoryBot.define do
  factory :article do
    title { 'Article title' }
    body { Faker::Lorem.sentence(word_count: 10) }

    transient do
      status { 'public' }
    end

    after(:build) do |article, evaluator|
      article.status = evaluator.status if evaluator.status.present?
    end

    trait :public do
      status { 'public' }
    end

    trait :private do
      status { 'private' }
    end

    trait :archived do
      status { 'archived' }
    end
  end
end
