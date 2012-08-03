class AddAcknowledgementToUser < ActiveRecord::Migration
  def change
    add_column :users, :privacy_effective_date, :date

  end
end
