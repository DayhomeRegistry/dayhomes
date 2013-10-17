class CreateCommunities < ActiveRecord::Migration
  def up
    create_table :communities do |t|
      t.string :name

      t.timestamps
    end

    add_column :locations,:community_id,:integer
  end

  def down
    drop_table :communities
    remove_column :location,:community_id
  end
end
