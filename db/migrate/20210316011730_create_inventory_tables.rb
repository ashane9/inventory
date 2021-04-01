class CreateInventoryTables < ActiveRecord::Migration[6.0]
  def change
  
    create_table :item_types do |t|
      t.string :type_name

      t.timestamps
    end
    
    create_table :authentications do |t|
      t.string :name

      t.timestamps
    end
    
    create_table :purchase_types do |t|
      t.string :type_name

      t.timestamps
    end
    
    create_table :values do |t|
      t.decimal :estimated_value, precision: 6, scale: 2, null: true
      t.date :as_of_date, null: true

      t.timestamps
    end
    
    create_table :purchases do |t|
      t.string :invoice_number, null: true
      t.references :purchase_type, foreign_key: true, null: false
      t.string :location, null: true
      t.date :date, null: true
      t.decimal :sale_price, null: true, precision: 5, scale: 2
      t.decimal :buyer_premium, null: true, precision: 5, scale: 2
      t.decimal :shipping, null: true, precision: 5, scale: 2
      t.decimal :total_cost, null: true, precision: 6, scale: 2

      t.timestamps
    end

    create_join_table :autographs, :authentications do |t|
      t.string :authentication_number, null: true
      t.timestamps
    end

    create_table :items do |t|
      t.string :item_name, null: false
      t.text :description, null: true
      t.references :item_type, foreign_key: true, null: false
      t.string :manufacturer, null: true
      t.string :size, null: true
      t.string :upc, null: true
      t.references :purchase, foreign_key: true, null: true
      t.references :value, foreign_key: true, null: true
      t.timestamps
    end
    
    create_table :autographs do |t|
      t.string :name, null: false
      t.references :item, foreign_key: true, null: false
      t.references :purchase, foreign_key: true, null: true
      t.references :value, foreign_key: true, null: true
      t.timestamps
    end
    
    
  end
end
