class Comment < ApplicationRecord
  include Visible

  belongs_to :article

  validates :commenter, presence: true
  validates :body, presence: true
  validates :article_id, presence: true
end
