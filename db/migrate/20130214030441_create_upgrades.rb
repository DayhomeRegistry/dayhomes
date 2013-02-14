class CreateUpgrades < ActiveRecord::Migration
  def change
    create_table :upgrades do |t|
			t.datetime	"effective_date", :default => DateTime.now()
			t.integer		"plan_id"
			
      t.timestamps
    end
  end
end
