class AddIXtoForum < ActiveRecord::Migration
  def change
    add_index :forums, :category_id
    add_index :topics, :user_id
    add_index :topics, :forum_id
    add_index :posts, :user_id
    add_index :posts, :forum_id
    add_index :posts, :topic_id
  end
end
