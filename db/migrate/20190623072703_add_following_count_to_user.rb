class AddFollowingCountToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :following_count, :integer, null: false, default: 0, after: :name
    add_column :users, :follower_count, :integer, null: false, default: 0, after: :name
  end
end
