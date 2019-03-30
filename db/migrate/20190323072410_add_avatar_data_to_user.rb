class AddAvatarDataToUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :avatar
    add_column :users, :avatar_data, :string, after: :name, comment: 'アバター画像情報'
  end
end
