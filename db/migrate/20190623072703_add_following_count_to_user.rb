class AddFollowingCountToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :following_count, :integer, after: :name
    add_column :users, :follower_count, :integer, after: :name
  end
end
