class Charge50 < ActiveRecord::Migration
  def up
   	babyannual = Plan.find_by_plan("babyannual")
 
   	baby50 = Plan.new(babyannual.attributes)
  	baby50.plan="baby50"
  	baby50.price=50
  	baby50.active=DateTime.now
  	baby50.save

  	babyannual.inactive = DateTime.now
  	babyannual.save


  end

  def down
  	babyannual = Plan.find_by_plan("babyannual")
  	babyannual.inactive = nil
  	babyannual.save

  	baby50 = Plan.find_by_plan("baby50")
  	baby50.destroy

  end
end
