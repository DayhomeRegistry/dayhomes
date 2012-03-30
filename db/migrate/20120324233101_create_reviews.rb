class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :content
      t.integer :rating, :default => 0
      t.integer :day_home_id
      t.integer :user_id

      t.timestamps
    end
  end
end
