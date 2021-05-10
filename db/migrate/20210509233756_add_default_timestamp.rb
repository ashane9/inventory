class AddDefaultTimestamp < ActiveRecord::Migration[6.0]
  def change
    change_column :authentications_autographs, :created_at, :timestamps, default: 'CURRENT_TIMESTAMP'
    change_column :authentications_autographs, :updated_at, :timestamps, default: 'CURRENT_TIMESTAMP'
  end
end
