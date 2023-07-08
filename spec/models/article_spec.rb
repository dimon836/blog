require 'rails_helper'

RSpec.describe Article, :type => :model do
  subject { described_class.new(
    title: "title",
    body: "some article body",
    status: "public"
  ) }

  describe "Validations" do

    it { is_expected.to be_valid }

    it { is_expected.to validate_presence_of(:title) }

    it { is_expected.to validate_presence_of(:body) }

    it 'is not valid with body length less than 10' do
      subject.body = "a" * 9
      expect(subject).to_not be_valid
    end

    it { is_expected.to validate_presence_of(:status) }

  end
end
