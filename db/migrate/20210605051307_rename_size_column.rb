class RenameSizeColumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :items, :size, :temp_size
  end
end
