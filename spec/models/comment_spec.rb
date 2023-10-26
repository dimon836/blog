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
require 'rails_helper'

RSpec.describe Comment do
  subject(:comment) { create(:comment) }

  describe 'validations' do
    it { is_expected.to be_valid }

    it { is_expected.to validate_presence_of(:commenter) }

    it { is_expected.to validate_presence_of(:body) }

    it { is_expected.to validate_presence_of(:status) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:article) }
  end

  describe 'indexes' do
    it { is_expected.to have_db_index(:article_id) }
  end

  describe 'enums' do
    it { is_expected.to define_enum_for(:status).with_values(published: 1, hidden: 2, archived: 3) }
  end
end
