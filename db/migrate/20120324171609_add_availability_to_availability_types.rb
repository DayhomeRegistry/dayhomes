class AddAvailabilityToAvailabilityTypes < ActiveRecord::Migration
  def change
    add_column :availability_types, :availability, :string

  end
end
