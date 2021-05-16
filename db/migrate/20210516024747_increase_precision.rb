class IncreasePrecision < ActiveRecord::Migration[6.1]
  def change
    change_column :values, :estimated_value, :decimal, precision: 10, scale: 2, null: true
    change_column :purchases, :sale_price, :decimal, precision: 10, scale: 2, null: true
    change_column :purchases, :buyer_premium, :decimal, precision: 10, scale: 2, null: true
    change_column :purchases, :shipping, :decimal, precision: 10, scale: 2, null: true
    change_column :purchases, :additional, :decimal, precision: 10, scale: 2, null: true
    change_column :purchases, :discount, :decimal, precision: 10, scale: 2, null: true
    change_column :purchases, :total_cost, :decimal, precision: 10, scale: 2, null: true
  end
end