require 'rails_helper'

RSpec.describe Comment, :type => :model do
  subject(:comment) do
    described_class.new(
      commenter: "John Doe",
      body: "some comment body",
      status: "public",
      article_id: article.id
    )
  end

  let(:article) do
    Article.new(id: 1,
                title: "title",
                body: "some article body",
                status: "public")
  end

  describe "Validations" do
    it 'is valid with valid attributes' do
      p article
      expect(comment).to be_valid
    end
  end

  describe "Associations" do
    it { is_expected.to belong_to(:article) }
  end
end
