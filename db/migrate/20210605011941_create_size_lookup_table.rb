class CreateSizeLookupTable < ActiveRecord::Migration[6.1]
  def change
    create_table :sizes do |t|
      t.string :item_size

      t.timestamps
    end

    change_table :items do |t|    
      t.references :size, foreign_key: true, null: true
    end
  end
end
