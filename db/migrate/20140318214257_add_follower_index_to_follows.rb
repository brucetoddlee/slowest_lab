class AddFollowerIndexToFollows < ActiveRecord::Migration
  def change
    add_index :follows, :follower_id
  end
end
