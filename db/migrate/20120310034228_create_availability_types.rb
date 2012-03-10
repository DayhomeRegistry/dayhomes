class CreateAvailabilityTypes < ActiveRecord::Migration
  def change
    create_table :availability_types do |t|
      t.string :kind

      t.timestamps
    end
  end
end
