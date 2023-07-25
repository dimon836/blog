class Comment < ApplicationRecord
  include Visible

  belongs_to :article

  validates :commenter, presence: true
  validates :body, presence: true

  def admin?
    !(commenter =~ /ADMIN, admin, ADMINISTRATOR/)
  end
end
