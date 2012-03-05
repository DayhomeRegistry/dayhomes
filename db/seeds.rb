# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

day_homes = ["T5N1Y6", "T5S1R5", "T6C0P9", "T5E4E5", "T6C2W1"]

# Create a couple of dayhomes
day_homes.each_with_index  do |d, index|
  DayHome.create!({:name => "Dayhome #{index}", :address => d})
end
