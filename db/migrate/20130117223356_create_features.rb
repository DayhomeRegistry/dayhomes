class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.date :start
      t.date :end

      t.timestamps
    end
  end
end
