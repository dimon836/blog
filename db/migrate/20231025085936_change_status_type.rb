# frozen_string_literal: true

class ChangeStatusType < ActiveRecord::Migration[7.0]
  def change
    reversible do |dir|
      dir.up do
        rename_column :articles, :status, :old_status
        add_column :articles, :status, :integer

        rename_column :comments, :status, :old_status
        add_column :comments, :status, :integer
        Rake::Task['status_type:convert_string_status_to_integer'].invoke([Article, Comment])
      end

      dir.down do
        remove_column :articles, :status
        rename_column :articles, :old_status, :status

        remove_column :comments, :status
        rename_column :comments, :old_status, :status
      end
    end
  end
end
