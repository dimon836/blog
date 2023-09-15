# frozen_string_literal: true

module Visible
  extend ActiveSupport::Concern

  class_methods do
    private

    def published_count
      published.count
    end
  end
end
