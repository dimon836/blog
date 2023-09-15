# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Article do
  subject(:article) { create(:article) }

  describe 'validations' do
    it { is_expected.to be_valid }

    it { is_expected.to validate_presence_of(:title) }

    it { is_expected.to validate_presence_of(:body) }

    it { is_expected.to validate_length_of(:body).is_at_least(10) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:comments) }
  end

  describe 'enums' do
    it { is_expected.to define_enum_for(:status).with_values(published: 1, hidden: 2, archived: 3) }
  end
end
