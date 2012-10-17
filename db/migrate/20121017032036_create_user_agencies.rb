class CreateUserAgencies < ActiveRecord::Migration
  def change
    create_table :user_agencies do |t|
      t.column :user_id, :integer
      t.column :agency_id, :integer

      t.timestamps
    end
  end
end
