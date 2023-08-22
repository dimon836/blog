require 'rails_helper'

RSpec.describe Article, type: :model do
  subject(:article) { create(:article) }

  describe 'validations' do
    it { is_expected.to be_valid }

    it { is_expected.to validate_presence_of(:title) }

    it { is_expected.to validate_presence_of(:body) }

    it { is_expected.to validate_length_of(:body).is_at_least(10) }

    it { is_expected.to validate_inclusion_of(:status).in_array(%w[public private archived]) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:comments) }
  end
end
