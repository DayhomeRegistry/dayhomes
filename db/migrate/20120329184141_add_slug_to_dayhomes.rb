class AddSlugToDayhomes < ActiveRecord::Migration
  def change
    add_column :day_homes, :slug, :string
    
    DayHome.all.each do |day_home|
      day_home.update_attribute(:slug, day_home.name.parameterize.gsub('-', ''))
    end
    
  end
end
