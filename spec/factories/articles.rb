# frozen_string_literal: true

FactoryBot.define do
  factory :article do
    title { 'Article title' }
    body { Faker::Lorem.sentence(word_count: 10) }

    transient do
      status { :published }
    end

    after(:build) do |article, evaluator|
      article.status = evaluator.status if evaluator.status.present?
    end

    trait :published do
      status { :published }
    end

    trait :hidden do
      status { :hidden }
    end

    trait :archived do
      status { :archived }
    end
  end
end
