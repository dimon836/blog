# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :article

  validates :commenter, presence: true
  validates :body, presence: true
  enum status: {
    published: 1,
    hidden: 2,
    archived: 3
  }
end
