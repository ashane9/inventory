class UpdateAuthColumnName < ActiveRecord::Migration[6.1]
  def change
    rename_column :authentications, :name, :auth_name
  end
end
