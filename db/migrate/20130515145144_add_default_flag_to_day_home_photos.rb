class AddDefaultFlagToDayHomePhotos < ActiveRecord::Migration
  def change
  	add_column :day_home_photos, :default_photo, :boolean, :default=>false
  end
end
