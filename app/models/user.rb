# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :rememberable, :validatable, :registerable

  validates :email, uniqueness: true
  validates :username, uniqueness: true, presence: true
end
