# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    commenter { Faker::Name.name }
    body { Faker::Lorem.sentence }

    article

    transient do
      status { :published }
    end

    after(:build) do |comment, evaluator|
      comment.status = evaluator.status if evaluator.status.present?
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
