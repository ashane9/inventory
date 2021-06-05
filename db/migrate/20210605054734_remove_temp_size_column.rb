class RemoveTempSizeColumn < ActiveRecord::Migration[6.1]
  def change
    remove_column :items, :temp_size
  end
end
