class CreatePosts < ActiveRecord::Migration[6.1]
  def change
    create_table :posts do |t|
      t.integer :user_id, null: false
      t.string :name, null: false
      t.text :comment, null: false
      t.float :evaluation, null: false
      t.timestamps
    end
  end
end
