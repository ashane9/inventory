class AddAdditionalAutographColumns < ActiveRecord::Migration[6.1]
  def change
    add_column :autographs, :description, :text, null: true
    change_table :autographs do |t|
      t.references :profession, null: true
      t.references :organization, null: true
    end

    create_table :professions do |t|
      t.string :profession_name
      t.timestamps
    end
    create_table :organizations do |t|
      t.string :org_name
      t.timestamps
    end
  end
end
