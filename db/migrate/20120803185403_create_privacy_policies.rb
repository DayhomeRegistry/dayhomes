class CreatePrivacyPolicies < ActiveRecord::Migration
  def change
    create_table :privacy_policies do |t|
      t.string :version
      t.date :effective_date

      t.timestamps
    end    
  end
end
