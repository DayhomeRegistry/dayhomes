class AddAgencyToPlan < ActiveRecord::Migration
  def change
  	add_column :plans, :agency, :boolean, default: true

  	p = Plan.find_by_plan("baby50")
  	p.agency = false
  	p.save
  end
end
