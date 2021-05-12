class AddDiscountColumn < ActiveRecord::Migration[6.1]
  def change
    add_column :purchases, :discount, :decimal, null: true, precision: 5, scale: 2
  end
end
