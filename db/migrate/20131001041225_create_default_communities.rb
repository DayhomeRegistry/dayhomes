class CreateDefaultCommunities < ActiveRecord::Migration
  def up
  	Community.create!(:name=>"Edmonton")
  	Community.create!(:name=>"Calgary")
  end

  def down
  	Community.delete_all
  end
end
