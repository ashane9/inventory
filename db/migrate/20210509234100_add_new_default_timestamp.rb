class AddNewDefaultTimestamp < ActiveRecord::Migration[6.0]
  def change
    change_column :authentications_autographs, :created_at, :datetime, default: Time.now
    change_column :authentications_autographs, :updated_at, :datetime, default: Time.now
  end
end
