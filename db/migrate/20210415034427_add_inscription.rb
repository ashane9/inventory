class AddInscription < ActiveRecord::Migration[6.1]
  def change    
    add_column :autographs, :inscription, :string, null: true
    add_column :autographs, :autograph_date, :date, null: true
    add_column :purchases, :additional, :decimal, null: true, precision: 5, scale: 2
  end
end
