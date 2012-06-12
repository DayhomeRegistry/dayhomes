class AddHighlightBlurbToDayHomes < ActiveRecord::Migration
  def change    
    add_column :day_homes, :highlight, :text
  end
end
