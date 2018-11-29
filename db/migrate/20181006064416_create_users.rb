class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: false, limit: 50
      t.string :email, null: false, limit: 100
      t.string :avatar, limit: 100
      t.string :crypted_password, null: false
      t.string :salt, null: false

      t.timestamps
    end
  end
end
