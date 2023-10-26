# frozen_string_literal: true

# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  commenter  :string
#  body       :text
#  article_id :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status     :integer
#
FactoryBot.define do
  factory :comment do
    commenter { Faker::Name.name }
    body { Faker::Lorem.sentence }

    article

    transient do
      status { Comment.statuses.keys.first }
    end

    after(:build) do |comment, evaluator|
      comment.status = evaluator.status if evaluator.status.present?
    end

    trait :published do
      status { Comment.statuses[:published] }
    end

    trait :hidden do
      status { Comment.statuses[:hidden] }
    end

    trait :archived do
      status { Comment.statuses[:archived] }
    end
  end
end
