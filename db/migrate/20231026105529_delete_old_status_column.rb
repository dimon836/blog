# frozen_string_literal: true

class DeleteOldStatusColumn < ActiveRecord::Migration[7.0]
  def change
    reversible do |dir|
      dir.up do
        remove_column :articles, :old_status, :string

        remove_column :comments, :old_status, :string
      end

      dir.down do
        add_column :articles, :old_status, :string
        add_column :comments, :old_status, :string

        Rake::Task['status_type:convert_integer_status_to_string'].invoke([Article, Comment])
      end
    end
  end
end
