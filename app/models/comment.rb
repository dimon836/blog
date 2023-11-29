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
class Comment < ApplicationRecord
  belongs_to :article

  scope :non_archived_comments, -> { where.not(status: Comment.statuses[:archived]) }

  enum status: {
    published: 1,
    hidden: 2,
    archived: 3
  }

  validates :commenter, presence: true
  validates :body, presence: true
  validates :status, presence: true, inclusion: { in: statuses.keys }
end
