FactoryBot.define do
  factory :comment do
    commenter { Faker::Name.name }
    body { Faker::Lorem.sentence }

    article

    transient do
      status { :public }
    end

    after(:build) do |comment, evaluator|
      comment.status = evaluator.status if evaluator.status.present?
    end

    trait :public do
      status { :public }
    end

    trait :private do
      status { :private }
    end

    trait :archived do
      status { :archived }
    end
  end
end
