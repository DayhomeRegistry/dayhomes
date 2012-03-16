class AddDayHomePhotos < ActiveRecord::Migration
  def change
    create_table :day_home_photos do |t|
      t.references :day_home
      t.string :photo
      t.string :caption
      t.timestamps
    end

    add_index :day_home_photos, :day_home_id
  end
end
