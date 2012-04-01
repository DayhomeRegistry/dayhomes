class CreateUserRoles < ActiveRecord::Migration
  def change
    create_table :user_day_homes do |t|
      t.integer :day_home_id
      t.integer :user_id
      t.timestamps
    end
    
    add_index :user_day_homes, :day_home_id
    add_index :user_day_homes, :user_id
    add_index :user_day_homes, [:day_home_id, :user_id]
  end
end
