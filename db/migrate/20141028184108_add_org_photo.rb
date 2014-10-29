class AddOrgPhoto < ActiveRecord::Migration
  def change
    create_table :organization_photos do |t|
      t.integer :logo_id
      t.integer :pin_id
      t.string :photo
      t.timestamps
    end
    # add_column :organizations, :logo_id, :integer
    # add_column :organizations, :pin_id, :integer

    add_index :organization_photos, :logo_id
    add_index :organization_photos, :pin_id
  end
end
