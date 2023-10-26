# frozen_string_literal: true

# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  title      :string
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status     :integer
#
class Article < ApplicationRecord
  include Visible

  has_many :comments, dependent: :destroy

  scope :active_articles, -> { where(status: Article.statuses[:published]) }

  enum status: {
    published: 1,
    hidden: 2,
    archived: 3
  }

  validates :title, presence: true, length: { maximum: 50 }
  validates :body, presence: true, length: { minimum: 10 }
  validates :status, presence: true, inclusion: { in: statuses.keys }
end
