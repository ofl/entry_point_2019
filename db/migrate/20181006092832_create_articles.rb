class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.references :user, foreign_key: true
      t.string :title
      t.text :body
      t.integer :comments_count, null: false, default: 0
      t.integer :favorites_count, null: false, default: 0

      t.timestamps
    end
  end
end
