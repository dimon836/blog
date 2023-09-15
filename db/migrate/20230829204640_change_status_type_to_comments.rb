# frozen_string_literal: true

class ChangeStatusTypeToComments < ActiveRecord::Migration[7.0]
  def change
    change_column_default(:comments, :status, from: :string, to: :integer)
  end
end
