class AddPrimaryKey < ActiveRecord::Migration[6.0]
  def change
    add_index :authentications_autographs, [:authentication_id, :autograph_id], :unique => true, name: "auto_auth_index"
  end
end
