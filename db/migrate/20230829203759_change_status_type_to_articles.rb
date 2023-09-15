# frozen_string_literal: true

class ChangeStatusTypeToArticles < ActiveRecord::Migration[7.0]
  def change
    change_column_default(:articles, :status, from: :string, to: :integer)
  end
end
