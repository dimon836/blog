require 'rails_helper'

RSpec.describe Comment, :type => :model do
  subject(:comment) { create(:comment) }

  describe "Validations" do
    it { is_expected.to be_valid }

    it { is_expected.to validate_presence_of(:commenter) }

    it { is_expected.to validate_presence_of(:body) }

    it { is_expected.to validate_inclusion_of(:status).in_array(%w[public private archived]) }
  end

  describe "Associations" do
    it { is_expected.to belong_to(:article) }
  end

  describe "Indexes" do
    it { is_expected.to have_db_index(:article_id) }
  end

  describe "#admin?" do
    it "determines if the commenter is admin" do
      %w[ADMIN admin ADMINISTRATOR administrator].each do |commenter|
        comment.commenter = commenter
        expect(comment).to be_admin
      end
    end
  end
end
