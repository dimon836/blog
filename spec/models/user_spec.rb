# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  subject(:user) { create(:user) }

  describe 'validations' do
    it { is_expected.to be_valid }

    it { is_expected.to validate_presence_of(:email) }

    it { is_expected.to validate_presence_of(:username) }

    it { is_expected.to validate_uniqueness_of(:email).ignoring_case_sensitivity }

    it { is_expected.to validate_uniqueness_of(:username) }
  end

  describe 'indexes' do
    it { is_expected.to have_db_index(:email) }

    it { is_expected.to have_db_index(:username) }
  end
end
