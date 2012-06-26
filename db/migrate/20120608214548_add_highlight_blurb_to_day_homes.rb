class AddHighlightBlurbToDayHomes < ActiveRecord::Migration
  def change    
    add_column :day_homes, :highlight, :string
  end
end
