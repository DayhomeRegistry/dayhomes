class NewPlans < ActiveRecord::Migration
  def change
  	Plan.all.each do |plan|
    	plan.inactive = DateTime.now
    	plan.save
    end

    # Private
    ## Basic
    basic = Plan.new()
    basic.name = "Basic"
  	basic.plan="private.monthly.basic.5"
  	basic.day_homes = 1
  	basic.staff = 1
  	basic.locales = 1
  	basic.price=5
  	basic.block_staff_addon = 0
  	basic.block_locales_addon = 0
  	basic.active=DateTime.now
  	basic.free_features = 1
  	basic.agency = 0
  	basic.save
  	plan = Plan.new(basic.attributes)
  	plan.id=nil
  	plan.subscription="yr"
  	plan.price = 50
  	plan.save

  	## Popular
  	plan = Plan.new(basic.attributes)
  	plan.id=nil
  	plan.name = "Popular"
  	plan.plan = "private.monthly.popular.10"
  	plan.price = 10
  	plan.free_features=3
  	plan.save
  	plan = Plan.new(plan.attributes)
  	plan.id=nil
  	plan.subscription="yr"
  	plan.price = 100
  	plan.save

  	## Premier
  	plan = Plan.new(basic.attributes)
  	plan.id=nil
  	plan.name = "Premier"
  	plan.plan = "private.monthly.premier.15"
  	plan.price = 15
  	plan.free_features=5
  	plan.save
  	plan = Plan.new(plan.attributes)
  	plan.id=nil
  	plan.subscription="yr"
  	plan.price = 150
  	plan.save

  	# Agency
  	## Basic
  	mama = Plan.find_by_plan("mama")
  	plan = Plan.new(mama.attributes)
  	plan.id=nil
  	plan.name = "Basic"
  	plan.plan = "agency.monthly.basic.50"
  	plan.inactive = nil
  	plan.save

  	## Popular
  	papa = Plan.find_by_plan("papa")
  	plan = Plan.new(papa.attributes)
  	plan.id=nil
  	plan.name = "Popular"
  	plan.plan = "agency.monthly.popular.150"
  	plan.price = 150
  	plan.inactive = nil
  	plan.save

  	## Premier
  	goldi = Plan.find_by_plan("goldilocks")
  	plan = Plan.new(goldi.attributes)
  	plan.id=nil
  	plan.name = "Premier"
  	plan.plan = "agency.monthly.premier.250"
  	plan.price = 250
  	plan.inactive = nil
  	plan.save

  end
end
