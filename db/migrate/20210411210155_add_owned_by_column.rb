class AddOwnedByColumn < ActiveRecord::Migration[6.1]
  def change
    add_column :items, :owned_by, :string
    add_column :autographs, :owned_by, :string
    add_column :purchases, :owned_by, :string
    add_column :values, :owned_by, :string
    add_column :authentications_autographs, :owned_by, :string
  end
end
