class CreateDayHomeContacts < ActiveRecord::Migration
  def change
    create_table :day_home_contacts do |t|
      t.string :day_home_email
      t.string :name
      t.string :email
      t.string :phone
      t.string :subject
      t.text :message
      t.references :day_home
      t.timestamps
    end
    
    add_index :day_home_contacts, :day_home_id
  end
end
