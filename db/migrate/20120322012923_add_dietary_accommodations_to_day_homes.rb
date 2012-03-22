class AddDietaryAccommodationsToDayHomes < ActiveRecord::Migration
  def change
    add_column :day_homes, :dietary_accommodations, :boolean
  end
end
