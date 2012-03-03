namespace :db do
  desc "Sample data"
  task :populate => :environment do

    create_dayhomes
  end
end

def create_dayhomes
  day_homes = ["T5N1Y6", "T5S1R5", "T6C0P9", "T5E4E5", "T6C2W1"]

  # Create a couple of dayhomes
  day_homes.each_with_index  do |d, index|
    DayHome.create!({:name => "Dayhome #{index}", :address => d})
  end

end