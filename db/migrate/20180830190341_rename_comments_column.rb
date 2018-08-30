class RenameCommentsColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :comments, :comments, :message
  end
end
