require 'rails_helper'

RSpec.describe Article, :type => :model do
  subject(:article) { create(:article) }

  describe "Validations" do
    it { is_expected.to be_valid }

    it { is_expected.to validate_presence_of(:title) }

    it { is_expected.to validate_presence_of(:body) }

    it 'is not valid with body length less than 10' do
      article.body = "a" * 9
      expect(article).to_not be_valid
    end

    it { is_expected.to validate_inclusion_of(:status).in_array(%w[public private archived]) }
  end
end
