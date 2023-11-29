# frozen_string_literal: true

module Visible
  extend ActiveSupport::Concern

  class_methods do
    delegate :count, to: :published, prefix: true
  end
end
